lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'madness/version'

Gem::Specification.new do |s|
  s.name        = 'madness'
  s.version     = Madness::VERSION
  s.summary     = 'Instant Markdown Server'
  s.description = 'Start a markdown server in any directory'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*', 'app/**/*']
  s.executables = ['madness']
  s.homepage    = 'https://github.com/DannyBen/madness'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.1'

  s.add_dependency 'addressable', '~> 2.7'
  s.add_dependency 'colsole', '~> 1.0'
  s.add_dependency 'extended_yaml', '~> 0.2'
  s.add_dependency 'mister_bin', '~> 0.7'
  s.add_dependency 'naturally', '~> 2.2'
  s.add_dependency 'os', '~> 1.0'
  s.add_dependency 'pandoc-ruby', '~> 2.1'
  s.add_dependency 'puma', '>= 5.1', '< 7'
  s.add_dependency 'rackup', '~> 2.1'
  s.add_dependency 'redcarpet', '~> 3.5'
  s.add_dependency 'requires', '~> 1.0'
  s.add_dependency 'rouge', '~> 4.0'
  s.add_dependency 'sinatra', '>= 3.0', '< 5'
  s.add_dependency 'slim', '>= 4.0', '< 6'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/madness/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/madness/blob/master/CHANGELOG.md',
    'homepage_uri'          => 'https://madness.dannyb.co/',
    'source_code_uri'       => 'https://github.com/DannyBen/madness',
    'rubygems_mfa_required' => 'true',
  }
end
