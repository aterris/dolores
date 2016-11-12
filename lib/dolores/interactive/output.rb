require 'dolores/utilities/word_wrap'

module Dolores
	module Interactive
		
    module Output

      def self.puts(*args)
        Pry.output.puts(*args)
      end

			def self.puts_left_chat_window(message)
				lines = split_message_for_chat_window(message)
	      longest_line = lines.map(&:length).max
	      
        horizontal_line = chat_window_vertical_line(longest_line)
	      spacer = chat_window_spacer(longest_line)
        left_margin = '    '

	      puts("\n")
	      puts(left_margin + horizontal_line)
	      puts(left_margin + spacer)
	      lines.each  { |line| puts(left_margin + "*  #{line}  *") }
        puts(left_margin + spacer)
        puts(left_margin + horizontal_line)
	      puts('     **')
	      puts('    *')
			end

			def self.puts_right_chat_window(message)
				lines = split_message_for_chat_window(message)
        longest_line = lines.map(&:length).max

        horizontal_line = chat_window_vertical_line(longest_line)
        spacer = chat_window_spacer(longest_line)
        max_width = 76

        puts(horizontal_line.rjust(max_width))
        puts(spacer.rjust(max_width))
        lines.each { |line| puts("*  #{line.ljust(longest_line)}  *".rjust(max_width)) }
        puts(spacer.rjust(max_width))
        puts(horizontal_line.rjust(max_width))
        puts((' ' * (max_width - 3)) + '** ')
        puts((' ' * (max_width - 1)) + '*')
			end

			def self.split_message_for_chat_window(message)
				Dolores::Utilities.word_wrap(message, line_width: 42).split("\n")
			end

      def self.chat_window_vertical_line(length)
         "*" * (length + 6)
      end

      def self.chat_window_spacer(length)
        space = ' ' * (length + 4)
        '*' + space + '*'
      end
			
		end
  end
end