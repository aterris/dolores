require 'bundler'
Bundler.require(:default)
Dotenv.load

Dir[File.dirname(__FILE__) + '/<%= @name %>/**/*.rb'].each {|file| require file }

Dolores.configure do |config|
  config.actions = '<%= @module_name %>::Actions'
end