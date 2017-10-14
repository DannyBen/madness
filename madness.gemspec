lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'madness/version'

Gem::Specification.new do |s|
  s.name        = 'madness'
  s.version     = Madness::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Instant Markdown Server"
  s.description = "Start a markdown server in any directory"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*', 'app/**/*' ]
  s.executables = ["madness"]
  s.homepage    = 'https://github.com/DannyBen/madness'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.1.0"

  s.add_runtime_dependency 'sass', '~> 3.4'
  s.add_runtime_dependency 'sinatra', '~> 2.0'
  s.add_runtime_dependency 'sinatra-contrib', '~> 2.0'
  s.add_runtime_dependency 'slim', '~> 3.0'
  s.add_runtime_dependency 'rdiscount', '~> 2.2'
  s.add_runtime_dependency 'coderay', '~> 1.1'
  s.add_runtime_dependency 'docopt', '~> 0.5'
  s.add_runtime_dependency 'colsole', '~> 0.4'
  s.add_runtime_dependency 'ferret', '~> 0.11'
  s.add_runtime_dependency 'puma', '~> 3.8'

  s.add_development_dependency 'runfile', '~> 0.9'
  s.add_development_dependency 'rack-test', '~> 0.7'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'byebug', '~> 9.1'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'rdoc', '~> 5.1'
  s.add_development_dependency 'simplecov', '~> 0.15'
  s.add_development_dependency 'yard', '~> 0.9'
  s.add_development_dependency 'rspec-html-matchers', '~> 0.9'
end
