require 'rspec'
 
ENV["RACK_ENV"] = 'test'
Bundler.require(:default, ENV['RACK_ENV']) if defined?(Bundler)
 
spec_dir = File.expand_path('../', __FILE__)
$:.unshift(spec_dir) unless $:.include? spec_dir
 
require File.expand_path('../../lib/dolores', __FILE__)
 
RSpec.configure do |config|
  config.mock_framework = :rspec
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end