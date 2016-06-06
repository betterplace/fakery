# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'fakery'
  author      'betterplace Developers'
  email       'developers@betterplace.org'
  homepage    "http://github.com/betterplace/#{name}"
  summary     'Fake Ruby objects from JSON API responses'
  description "This library fakes ruby objects from JSON API responses for testing purposes."
  test_dir    'spec'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '.rvmrc',
    '.ruby-version', '.AppleDouble', 'tags', '.DS_Store', '.utilsrc', 'doc',
    'errors.lst', '.byebug_history'
  readme      'README.md'
  title       "#{name.camelize} -- "
  licenses    << 'Apache-2.0'
  required_ruby_version '~>2.1'

  dependency 'tins',           '~>1.0'
  dependency 'term-ansicolor', '~>1.3'
  dependency 'typhoeus',       '~>1.0'
  dependency 'json',           '~>1.0'
  development_dependency 'simplecov'
  development_dependency 'rspec',     '~>3.0'
  development_dependency 'rspec-nc'
end

task :default => :spec
