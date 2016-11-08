module Dolores
  module Interactive
    class REPL

      def initialize(options)
        Pry.config.prompt_name = 'dolores'
        Pry.config.requires << options[:require] if options[:require]

        Pry.start(Pry.toplevel_binding, {
          :commands => Dolores::Interactive::Commands
        })
      end

    end
  end
end