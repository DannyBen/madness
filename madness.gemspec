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
  s.required_ruby_version = '>= 2.7'

  s.add_runtime_dependency 'addressable', '~> 2.7'
  s.add_runtime_dependency 'coderay', '~> 1.1'
  s.add_runtime_dependency 'colsole', '~> 0.7.2'
  s.add_runtime_dependency 'commonmarker', '~> 0.23', '>= 0.23.4'
  s.add_runtime_dependency 'docopt', '~> 0.6'
  s.add_runtime_dependency 'extended_yaml', '~> 0.2.3'
  s.add_runtime_dependency 'naturally', '~> 2.2'
  s.add_runtime_dependency 'os', '~> 1.0'
  s.add_runtime_dependency 'puma', '>= 5.1'
  s.add_runtime_dependency 'requires', '~> 1.0'
  s.add_runtime_dependency 'sinatra', '~> 3.0'
  s.add_runtime_dependency 'slim', '~> 4.0'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/madness/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/madness/blob/master/CHANGELOG.md',
    'homepage_uri'          => 'https://madness.dannyb.co/',
    'source_code_uri'       => 'https://github.com/DannyBen/madness',
    'rubygems_mfa_required' => 'true',
  }
end
