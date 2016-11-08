require 'dolores/utilities/word_wrap'

module Dolores
  module Channels
    class Interactive

      class Request
        attr_accessor :channel
        attr_accessor :message
        attr_accessor :address

        def initialize(message, channel)
          @channel = channel || :interactive
          @address = '+12487014123'
          @message = message
        end
      end

      def send(body:)
        Dolores::Interactive::Output.puts_right_chat_window(body)
      end
      
    end
  end
end