class Fakery::Change
  # +name+ is the name of the changed field. +from+ is the original value from
  # which the field was changed. +to+ is the new value to which the field was
  # changed. If +added+ is false (default) this is a change from previously set
  # value, if it's true then this change is a new addition of a field.
  def initialize(name: nil, from: nil, to: nil, added: false) # TODO remove nil in Ruby 2.1
    name or raise ArgumentError, 'name keyword argument is required'
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

  module Support
    extend Tins::Concern

    included do
      singleton_class.class_eval do
        extend Tins::ThreadLocal
        thread_local :ignore_changesp
      end
    end

    # Record the change to +new_value+ for the field +name+.
    def record_change(name, new_value)
      old_value = self[name]
      if old_value != new_value
        @changes << Fakery::Change.new(
          name:  name,
          from:  old_value,
          to:    new_value,
          added: !table.key?(name)
        )
      end
      self
    end

    module ClassMethods
      # Return true iff in ignoring changes mode.
      def ignore_changes?
        ignore_changesp
      end

      # Ignore the changes during execution of the yielded block.
      def ignore_changes
        old, self.ignore_changesp = ignore_changesp, true
        yield
      ensure
        self.ignore_changesp = old
      end
    end
  end
end
