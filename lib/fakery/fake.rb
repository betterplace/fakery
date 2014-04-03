class Fakery::Fake < JSON::GenericObject
  include Fakery::Change::Support

  class << self
    def cast(fake)
      case
      when self === fake
        fake
      when Fakery.registered?(fake)
        Fakery.build(fake)
      when fake.respond_to?(:to_hash)
        from_hash(fake.to_hash)
      when fake.respond_to?(:to_str)
        from_json(fake.to_str)
      else
        raise ArgumentError, "cannot cast #{fake.inspect}"
      end
    end

    def from_hash(*a, &b)
      ignore_changes { super }
    end

    def from_json(json)
      json.respond_to?(:read) and json = json.read
      from_hash JSON.parse(json)
    end

    def seed_from_url(api_seed_url)
      ignore_changes do
        new.tap do |obj|
          obj.__api_seed_url__ = api_seed_url
        end.__send__(:reseed)
      end
    end
  end

  def initialize(*)
    super
    @changes = Set[]
  end

  def as_json(*)
    to_hash
  end

  private

  attr_reader :changes

  def http_response(type: :typhoeus, http_status: 200)
    ::Typhoeus::Response.new(code: http_status, body: JSON(self)).tap do |r|
      r.ask_and_send(:mock=, true)
    end
  end

  def reseed
    myself = self
    self.class.from_hash(Fakery::Api.get(__api_seed_url__)).instance_eval do
      self.__api_seed_url__ = myself.__api_seed_url__
      for (name, value) in table
        myself[name] = value
      end
    end
    myself
  end

  def register_as_ruby(register_name)
    register_name = register_name.to_sym
    result = <<EOT
Fakery.register(#{register_name.inspect}, %{
#{JSON.pretty_generate(self).gsub(/^/, '  ')}
})
EOT
  end

  def initialize_copy(other)
    other.instance_variable_set :@changes, @changes.dup
    super
  end

  def new_ostruct_member(name)
    name = name.to_sym
    # Let's not define any singleton methods for write accessors
    if name !~ /=\z/
      define_singleton_method(name) { @table[name] }
    end
    name
  end

  def method_missing(id, *args, &block)
    if id =~ /=\z/
      args.size > 1 and
        raise ArgumentError, "wrong number of arguments (#{len} for 1)", caller(1)
      name  = $`.to_sym
      value = args.first
      self.class.ignore_changes? or record_change(name, value)
      modifiable[name] = value
    else
      super
    end
  end
end
