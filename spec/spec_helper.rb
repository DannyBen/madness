# Simplecov coverage reports
require 'simplecov'
SimpleCov.start

# Require the Gemfile
require 'rubygems'
require 'bundler'
Bundler.require :default, :development

# Sinatra testing with Rack::Test
require 'rack/test'
ENV['RACK_ENV'] = 'test'

# Create tmp folder for any spec that needs it
unless Dir.exist? 'tmp'
  Dir.mkdir 'tmp'
  puts '[spec_helper] creating tmp dir'
end

# Include us
include Madness

# Bootstrap Sinatra testing with rspec
module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class.prepare
    described_class
  end
end

# Configure RSpec
RSpec.configure do |config|
  config.include RSpecMixin
  config.include RSpecHtmlMatchers
  config.include ServerHelper
  config.approvals_path = File.expand_path 'fixtures', __dir__
end
