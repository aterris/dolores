require 'erb'
require 'pathname'
require 'fileutils'
require 'active_support/core_ext/string/inflections'

module Dolores
  class Bootstrap

    def initialize(name)
      @name = name.parameterize.underscore
      @module_name = @name.camelcase
      @api_name = "#{@name}_api"
      @api_module_name = "#{@name.camelcase}Api"
      @pretty_name = @name.titleize

      @cookie_secret = SecureRandom.uuid
      
      @bot_root = "#{Dir.pwd}/#{@name}"
      @dolores_root = File.expand_path(File.dirname(__FILE__))

      generate_directories
      generate_files
      bundle_install

      puts "\n  #{@name} created!"
    end

    def generate_directories
      generate_directory @bot_root
      generate_directory "#{@bot_root}/lib"
      generate_directory "#{@bot_root}/lib/#{@name}"
      generate_directory "#{@bot_root}/lib/#{@name}/actions"
      generate_directory "#{@bot_root}/spec"
    end

    def generate_directory(path)
      FileUtils.mkdir_p path

      relative_path = Pathname.new(path).relative_path_from(Pathname.new(@bot_root))
      display_create(relative_path)
    end

    def generate_files
      generate_file 'gitignore', '.gitignore'
      generate_file 'env', '.env'
      generate_file 'config.ru'
      generate_file 'Procfile'
      generate_file 'Gemfile'
      generate_file 'README.md'
      generate_file 'spec/spec_helper.rb'
      generate_file 'bot_api.rb', "#{@api_name}.rb"
      generate_file 'lib/bot.rb', "lib/#{@name}.rb"
      generate_file 'lib/bot/actions/get_forecast.rb', "lib/#{@name}/actions/get_forecast.rb"
    end

    def generate_file(path, output_path=nil)
      output_path ||= path

      file = File.open("#{@dolores_root}/bootstrap/templates/#{path}", 'rb') { |file| file.read }
      File.write("#{@bot_root}/#{output_path}", ERB.new(file).result(binding))
      display_create(output_path)
    end

    def bundle_install
      Dir.chdir("#{Dir.pwd}/#{@name}") do
        Bundler.with_clean_env do
          system 'bundle install --quiet'
        end
      end
      display_run('bundle install')
    end

    def display_create(path)
      puts "    \e[37mcreate\e[0m  #{path}"
    end

    def display_run(command)
      puts "       \e[37mrun\e[0m  #{command}"
    end

  end
end