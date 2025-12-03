# Simplecov coverage reports
require 'simplecov'
SimpleCov.start do
  # Set a different command name when the base_uri specs are executed
  # in order to get the aggregated coverage
  #
  # To run specs with full coverage, run: 'rspec ; STANDALONE=1 rspec'
  command_name ENV['STANDALONE'] ? 'RSpec-standalone' : 'RSpec'
end

# Require the Gemfile
require 'rubygems'
require 'bundler'

# The server_base_uri spec gets a special treatment here.
#
#   1. It is excluded from normal runs
#   2. It is executed when setting STANDALONE=1
#   3. For it to work, we are setting base_uri *before* requiring the bundle.
#
# The reason for this is that we need the Server class to be evaluated
# (required) after base_uri is set.
if ENV['STANDALONE']
  require 'madness/refinements/hash_refinements'
  require 'madness/settings'
  Madness::Settings.instance.base_uri = '/docs'
end

Bundler.require :default, :development, :test

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

  if ENV['STANDALONE']
    config.filter_run_including :standalone
  else
    config.filter_run_excluding :standalone
  end

  config.example_status_persistence_file_path = 'spec/status.txt'
end
