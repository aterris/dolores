require 'securerandom'
require 'dolores/channels/interactive'

module Dolores::Interactive
  class Command::Converse < Pry::ClassCommand
    match 'converse'
    group 'Wit'
    description 'Converse with wit.ai.'

    def process(message, channel=nil)
      Dolores::Interactive::Output.puts_left_chat_window(message)

      conversation_request = Dolores::Channels::Interactive::Request.new(message, channel)
      
      Dolores::Wit::Conversation.new({
        conversation_id: SecureRandom.uuid,
        context: {},
        request: conversation_request
      })
    end
  end

  Commands.add_command(Command::Converse)
end