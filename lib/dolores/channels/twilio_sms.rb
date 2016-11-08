require 'twilio-ruby'
require 'active_support/core_ext/hash'

module Dolores
  module Channels
    class TwilioSMS

      class Request
        attr_accessor :channel
        attr_accessor :params

        def initialize(request)
          @channel = :twilio_sms
          @params = Rack::Utils.parse_query(request.body.read).symbolize_keys

          validate(request) unless ENV['RACK_ENV'] == 'development'
        end

        def address
          @params[:From]
        end

        def message
          @params[:Body]
        end

        private
        def validate(request)
          puts "here"
          validator = Twilio::Util::RequestValidator.new(Dolores.configuration.twilio_token)
          url = request.url
          signature = request.env['HTTP_X_TWILIO_SIGNATURE']

          unless validator.validate(url, @params, signature)
            raise Dolores::Error.new('Invalid Twilio Request') if @context.nil?
          end
        end
      end

      def send(options = {})
        raise Dolores::Error.new('Twilio SMS: Missing Receipient Number') unless options[:to]
        raise Dolores::Error.new('Twilio SMS: Missing Body') unless options[:body]
        raise Dolores::Error.new('Twilio SMS: Missing Twilio Number') unless Dolores.configuration.twilio_sms_number

        options[:from] = Dolores.configuration.twilio_sms_number

        Dolores.log.info 'Twilio: Send Message'
        Dolores.log.debug options

        client.messages.create(options)
      end

      def client
        Twilio::REST::Client.new(Dolores.configuration.twilio_sid, Dolores.configuration.twilio_token)
      end
      
    end
  end
end