# encoding: utf-8

# environment
ENV['RACK_ENV'] ||= 'development'

# sinatra app
require './<%= @api_name %>'

map '/' do
  run <%= @api_module_name %>
end