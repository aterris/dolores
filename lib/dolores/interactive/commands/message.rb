module Dolores::Interactive
  class Command::Message < Pry::ClassCommand
    match 'message'
    group 'Wit'
    description 'Determine meaning from text'

    def process(message)
    	response = Dolores::Wit::API.new().message(message)

		  Dolores::Interactive::Output.puts(JSON.pretty_generate(response))
    end
  end

  Commands.add_command(Command::Message)
end