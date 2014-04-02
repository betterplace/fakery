class Fakery::Change
  def initialize(name:, from:, to:, added: false)
    @name, @from, @to, @added = name, from, to, added
  end

  attr_reader :name

  attr_reader :from

  attr_reader :to

  def added?
    !!@added
  end

  def to_s
    "<#{self.class} name=#{@name.inspect} from=#{@from.inspect}#{?* if @added} to=#{@to.inspect}>"
  end

  alias inspect to_s
end
