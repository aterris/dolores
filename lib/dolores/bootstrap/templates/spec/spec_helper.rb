require 'rspec'
 
ENV["RACK_ENV"] = 'test'
Bundler.require(:default, ENV['RACK_ENV']) if defined?(Bundler)
 
spec_dir = File.expand_path('../', __FILE__)
$:.unshift(spec_dir) unless $:.include? spec_dir
 
require File.expand_path('../../"#{@api_name}"', __FILE__)
require File.expand_path('../../lib/<%= @name %>', __FILE__)
 
RSpec.configure do |config|
  config.mock_framework = :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end