module Fakery::Registry
  module_function

  def registered_fakes
    @registered_fakes ||= {}
  end
  private :registered_fakes

  # Clear all registered fakes.
  def clear
    registered_fakes.clear
  end

  # Returns true, if there is a fake registered under name +name+.
  def registered?(name)
    name.respond_to?(:to_sym) && registered_fakes.key?(name.to_sym)
  end

  # Registers +fake+ under name +register_name. (A fake is either a
  # Fakery::Fake instance or a string containing a JSON representation to be
  # faked. If a fake was already registered under this name a warning will be
  # displayed.
  def register(register_name, fake)
    register_name = register_name.to_sym
    if registered?(register_name)
      warn "WARNING: Overwriting a fake for an already registered name #{register_name.inspect}."
    end
    registered_fakes[register_name] = Fakery::Fake.cast(fake)
  end

  def register_files(*files)
    files = files.flatten
    puts "Registering fakes…"
    for file in files
      name = File.basename(file).sub('.json', '').to_sym
      Fakery.register(name, File.read(file))
      puts "Just registered the fake #{name.inspect}"
    end
    puts "Done."
  end

  # Builds a the fake registered under the name +register_name+. All its fields
  # can be changed according to the names and values in the +with+ keyword
  # argument or later by using setters on the object.
  def build(register_name, with: {})
    register_name = register_name.to_sym
    fake = registered_fakes.fetch(register_name).dup
    for (name, value) in with
      fake[name] = value
    end
    fake
  rescue KeyError
    raise ArgumentError, "no fake registered under the name #{register_name.inspect}"
  end

  # Returns the ruby source to register +fake+ under the +name+.
  def source(name, fake)
    fake = Fakery::Fake.cast(fake)
    fake.__send__(:register_as_ruby, name)
  end
end
