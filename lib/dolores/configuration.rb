module Dolores

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :wit_actions
    
    def initialize
      @wit_actions = 'Dolores::Actions'
    end

    def wit_token
      ENV['DOLORES_WIT_TOKEN']
    end

    def wit_api_version
      ENV['DOLORES_WIT_API_VERSION'] || '20160526'
    end

    def twilio_token
      ENV['DOLORES_TWILIO_TOKEN']
    end

    def twilio_sid
      ENV['DOLORES_TWILIO_SID']
    end

    def twilio_sms_number
      ENV['DOLORES_TWILIO_SMS_NUMBER']
    end

    def log_level=(level)
      Dolores.log.level = level
    end
  end
end