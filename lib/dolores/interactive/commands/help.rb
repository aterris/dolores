module Dolores::Interactive
  class Command::Help < Pry::Command::Help
    group 'Help'

    def group_sort_key(group_name)
      [%w(Help Wit Commands).index(group_name.tr(' ', '_')) || 99, group_name]
    end
  end

  Commands.add_command(Command::Help)
end