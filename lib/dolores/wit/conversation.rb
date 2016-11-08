require 'active_support/core_ext/string/inflections'

module Dolores
  module Wit
    class Conversation
      attr_accessor :context

      def initialize(options={})
        raise Dolores::Error.new('Conversation ID Required') unless options[:conversation_id]
        raise Dolores::Error.new('Request Required') unless options[:request]

        @session_id = options[:conversation_id]
        @context = options[:context] || {}
        @request = options[:request]
        
        converse(@request.message)
      end

      private
      def client
        @client ||= Dolores::Wit::API.new()
      end

      def converse(message)
        json = client.converse(message, session_id: @session_id, context: @context)

        raise Dolores::Error.new('Oops, I don\'t know what to do.') if json['type'] == 'error'
        return if json['type'] == 'stop'

        request = {
          'session_id' => @session_id,
          'context' => @context.clone,
          'text' => message,
          'entities' => json['entities']
        }

        if json['type'] == 'msg'
          response = {
            'channel' => @request.channel,
            'address' => @request.address,
            'text' => json['msg'],
            'quickreplies' => json['quickreplies'],
          }

          respond(request, response)
        elsif json['type'] == 'action'
          @context = action(json['action'].to_sym).perform(request)
          raise Dolores::Error.new('Missing Context') if @context.nil?
        else
          raise Dolores::Error.new("unknown type: #{json['type']}")
        end

        return converse(nil)
      end

      def respond(request, response)
        case response['channel']
        when :twilio_sms
          Dolores::Channels::TwilioSMS.new().send({
            to: response['address'],
            body: response['text']
          })
        when :interactive
          Dolores::Channels::Interactive.new().send(body: response['text'])
        end
      end

      def action(name)
        "#{Dolores.configuration.wit_actions}::#{name.to_s.camelize}".constantize.new()
      end
    end
  end
end