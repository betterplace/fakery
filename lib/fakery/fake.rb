class Fakery::Fake < JSON::GenericObject
  class << self
    extend Tins::ThreadLocal
    thread_local :ignore_changesp
    extend Tins::Delegate

    def ignore_changes?
      ignore_changesp
    end

    def ignore_changes
      old, self.ignore_changesp = ignore_changesp, true
      yield
    ensure
      self.ignore_changesp = old
    end

    def from_json(json)
      json.respond_to?(:read) and json = json.read
      ignore_changes do
        from_hash(JSON.parse(json))
      end
    end

    def seed_from_url(api_seed_url)
      ignore_changes do
        new.tap do |obj|
          obj.__api_seed_url__ = api_seed_url
        end.seed!
      end
    end
  end

  def initialize(*)
    super
    @changes = Set[]
  end

  def __changes__
    @changes
  end

  def seed!
    myself = self
    self.class.from_hash(Api.get(__api_seed_url__)).instance_eval do
      self.__api_seed_url__ = myself.__api_seed_url__
      for (name, value) in table
        myself[name] = value
      end
    end
    myself
  end

  def http_response(type: :typhoeus, http_status: 200)
    ::Typhoeus::Response.new(code: http_status, body: JSON(self)).tap do |r|
      r.ask_and_send(:mock=, true)
    end
  end

  private def initialize_copy(other)
    other.instance_variable_set :@changes, @changes.dup
    super
  end

  def register_as_ruby(register_name)
    register_name = register_name.to_sym
    result = <<EOT
Fakery.register(#{register_name.inspect}, %{
#{JSON.pretty_generate(self).gsub(/^/, '  ')}
})
EOT
  end

  def new_ostruct_member(name)
    name = name.to_sym
    # Let's not define any singleton methods for write accessors
    if name !~ /=\z/
      define_singleton_method(name) { @table[name] }
    end
    name
  end

  def as_json(*)
    to_hash
  end

  def method_missing(id, *args, &block)
    if id =~ /=\z/
      args.size > 1 and
        raise ArgumentError, "wrong number of arguments (#{len} for 1)", caller(1)
      name  = $`.to_sym
      value = args.first
      unless self.class.ignore_changes?
        old_value = self[name]
        if old_value != value
          @changes << Fakery::Change.new(
            name:  name,
            from:  old_value,
            to:    value,
            added: !table.key?(name)
          )
        end
      end
      modifiable[name] = value
    else
      super
    end
  end
end
