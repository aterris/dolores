# encoding: utf-8
require './lib/<%= @name %>'

class <%= @api_module_name %> < Sinatra::Base
  use Rack::Lint
  use Rack::Runtime

  use Rack::Session::Cookie, {
    :key => 'rack.session',
    :path => '/',
    :expire_after => 60*5,
    :secret => '<%= @cookie_secret %>'
  }

  before do
    session[:conversation_id] ||= SecureRandom.uuid
  end

  get '/' do
    '<%= @pretty_name %>'
  end

  post '/twilio-sms' do
    conversation_request = Dolores::Channels::TwilioSMS::Request.new(request)
    
    conversation = Dolores::Conversation.new({
      conversation_id: session[:conversation_id],
      context: session[:context],
      request: conversation_request
    })

    session[:context] = conversation.context
    status 200
  end
end