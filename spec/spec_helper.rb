require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include Madness

RSpec.configure do |config|
  config.filter_run_excluding type: :premium unless ENV['QUANDL_PREMIUM']
end
