require 'logging'

module Dolores

  def self.log
    return @log if @log

    @log = Logging.logger['delores']
    Logging.appenders.stdout(
      :layout => Logging.layouts.basic(:format_as => :json)
    )

    @log.appenders = 'stdout'
    @log.level = :info
    @log
  end

end