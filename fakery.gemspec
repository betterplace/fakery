# -*- encoding: utf-8 -*-
# stub: fakery 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fakery".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["betterplace Developers".freeze]
  s.date = "2017-01-02"
  s.description = "This library fakes ruby objects from JSON API responses for testing purposes.".freeze
  s.email = "developers@betterplace.org".freeze
  s.extra_rdoc_files = ["README.md".freeze, "lib/fakery.rb".freeze, "lib/fakery/api.rb".freeze, "lib/fakery/api_error.rb".freeze, "lib/fakery/change.rb".freeze, "lib/fakery/fake.rb".freeze, "lib/fakery/fakery_error.rb".freeze, "lib/fakery/registry.rb".freeze, "lib/fakery/seeding.rb".freeze, "lib/fakery/state_error.rb".freeze, "lib/fakery/version.rb".freeze, "lib/fakery/wrapping.rb".freeze]
  s.files = [".gitignore".freeze, ".rspec".freeze, ".travis.yml".freeze, "Gemfile".freeze, "LICENSE".freeze, "README.md".freeze, "Rakefile".freeze, "TODO.md".freeze, "VERSION".freeze, "fakery.gemspec".freeze, "lib/fakery.rb".freeze, "lib/fakery/api.rb".freeze, "lib/fakery/api_error.rb".freeze, "lib/fakery/change.rb".freeze, "lib/fakery/fake.rb".freeze, "lib/fakery/fakery_error.rb".freeze, "lib/fakery/registry.rb".freeze, "lib/fakery/seeding.rb".freeze, "lib/fakery/state_error.rb".freeze, "lib/fakery/version.rb".freeze, "lib/fakery/wrapping.rb".freeze, "spec/api_spec.rb".freeze, "spec/change_spec.rb".freeze, "spec/fake_spec.rb".freeze, "spec/registry_spec.rb".freeze, "spec/seeding_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/wrapping_spec.rb".freeze]
  s.homepage = "http://github.com/betterplace/fakery".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rdoc_options = ["--title".freeze, "Fakery -- ".freeze, "--main".freeze, "README.md".freeze]
  s.required_ruby_version = Gem::Requirement.new("~> 2.1".freeze)
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Fake Ruby objects from JSON API responses".freeze
  s.test_files = ["spec/api_spec.rb".freeze, "spec/change_spec.rb".freeze, "spec/fake_spec.rb".freeze, "spec/registry_spec.rb".freeze, "spec/seeding_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/wrapping_spec.rb".freeze]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-nc>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<tins>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<term-ansicolor>.freeze, ["~> 1.3"])
      s.add_runtime_dependency(%q<typhoeus>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<json>.freeze, ["< 3", ">= 1.0"])
    else
      s.add_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rspec-nc>.freeze, [">= 0"])
      s.add_dependency(%q<tins>.freeze, ["~> 1.0"])
      s.add_dependency(%q<term-ansicolor>.freeze, ["~> 1.3"])
      s.add_dependency(%q<typhoeus>.freeze, ["~> 1.0"])
      s.add_dependency(%q<json>.freeze, ["< 3", ">= 1.0"])
    end
  else
    s.add_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rspec-nc>.freeze, [">= 0"])
    s.add_dependency(%q<tins>.freeze, ["~> 1.0"])
    s.add_dependency(%q<term-ansicolor>.freeze, ["~> 1.3"])
    s.add_dependency(%q<typhoeus>.freeze, ["~> 1.0"])
    s.add_dependency(%q<json>.freeze, ["< 3", ">= 1.0"])
  end
end
