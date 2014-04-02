class Fakery::Change
  def initialize(name:, from:, to:, added: true)
    @name, @from, @to, @added = name, from, to, added
  end

  def to_s
    "<#{self.class} name=#{@name.inspect} from=#{@from.inspect}#{?* if @added} to=#{@to.inspect}>"
  end

  alias inspect to_s
end
