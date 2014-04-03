# -*- encoding: utf-8 -*-
# stub: fakery 0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fakery"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["betterplace Developers"]
  s.date = "2014-04-03"
  s.description = "This library fakes ruby objects from JSON API responses for testing purposes."
  s.email = "developers@betterplace.org"
  s.extra_rdoc_files = ["README.md", "lib/fakery.rb", "lib/fakery/api.rb", "lib/fakery/api_error.rb", "lib/fakery/change.rb", "lib/fakery/fake.rb", "lib/fakery/fakery_error.rb", "lib/fakery/registry.rb", "lib/fakery/version.rb"]
  s.files = [".gitignore", ".rspec", ".travis.yml", "Gemfile", "LICENSE", "README.md", "Rakefile", "TODO.md", "VERSION", "fakery.gemspec", "lib/fakery.rb", "lib/fakery/api.rb", "lib/fakery/api_error.rb", "lib/fakery/change.rb", "lib/fakery/fake.rb", "lib/fakery/fakery_error.rb", "lib/fakery/registry.rb", "lib/fakery/version.rb", "spec/api_spec.rb", "spec/change_spec.rb", "spec/fake_spec.rb", "spec/registry_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/betterplace/fakery"
  s.rdoc_options = ["--title", "Fakery -- ", "--main", "README.md"]
  s.rubygems_version = "2.2.2"
  s.summary = "Fake Ruby objects from JSON API responses"
  s.test_files = ["spec/api_spec.rb", "spec/change_spec.rb", "spec/fake_spec.rb", "spec/registry_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 1.0.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.8"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<fuubar>, ["~> 1.3"])
      s.add_development_dependency(%q<rspec-nc>, [">= 0"])
      s.add_development_dependency(%q<byebug>, ["~> 2.0"])
      s.add_runtime_dependency(%q<tins>, ["~> 1.0"])
      s.add_runtime_dependency(%q<term-ansicolor>, ["~> 1.3"])
      s.add_runtime_dependency(%q<typhoeus>, ["~> 0.6.0"])
      s.add_runtime_dependency(%q<json>, ["~> 1.0"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 1.0.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.8"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<fuubar>, ["~> 1.3"])
      s.add_dependency(%q<rspec-nc>, [">= 0"])
      s.add_dependency(%q<byebug>, ["~> 2.0"])
      s.add_dependency(%q<tins>, ["~> 1.0"])
      s.add_dependency(%q<term-ansicolor>, ["~> 1.3"])
      s.add_dependency(%q<typhoeus>, ["~> 0.6.0"])
      s.add_dependency(%q<json>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 1.0.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.8"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<fuubar>, ["~> 1.3"])
    s.add_dependency(%q<rspec-nc>, [">= 0"])
    s.add_dependency(%q<byebug>, ["~> 2.0"])
    s.add_dependency(%q<tins>, ["~> 1.0"])
    s.add_dependency(%q<term-ansicolor>, ["~> 1.3"])
    s.add_dependency(%q<typhoeus>, ["~> 0.6.0"])
    s.add_dependency(%q<json>, ["~> 1.0"])
  end
end
