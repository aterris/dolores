lib_path = File.expand_path('../', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

require 'dolores/version'
require 'dolores/log'
require 'dolores/exceptions'
require 'dolores/configuration'
require 'dolores/wit'
require 'dolores/channels/twilio_sms'