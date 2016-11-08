module Dolores
  module Interactive
    Commands = Pry::CommandSet.new
    module Command
    end
  end
end

Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }

Dolores::Interactive::Commands.add_command(Pry::Command::Cd)
Dolores::Interactive::Commands.add_command(Pry::Command::Ls)
Dolores::Interactive::Commands.add_command(Pry::Command::Cd)
Dolores::Interactive::Commands.add_command(Pry::Command::WatchExpression)
Dolores::Interactive::Commands.add_command(Pry::Command::Wtf)