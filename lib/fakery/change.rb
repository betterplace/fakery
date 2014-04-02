class Fakery::Change
  # +name+ is the name of the changed field. +from+ is the original value from
  # which the field was changed. +to+ is the new value to which the field was
  # changed. If +added+ is false (default) this is a change from previously set
  # value, if it's true then this change is a new addition of a field.
  def initialize(name:, from:, to:, added: false)
    @name, @from, @to, @added = name, from, to, added
  end

  attr_reader :name # Name of the changed field.

  attr_reader :from # Original value from which the field was changed.

  attr_reader :to   # New value to which the field was changed.

  # Returns true if the field was newly added with this change.
  def added?
    !!@added
  end

  # Returns a string representation of this change. A change from=nil* is an
  # addition change as opposed to a regular change from some previous value.
  def to_s
    "<#{self.class} name=#{@name.inspect} from=#{@from.inspect}#{?* if @added} to=#{@to.inspect}>"
  end

  alias inspect to_s
end
