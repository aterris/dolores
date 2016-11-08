require 'httparty'

module Dolores
  module Wit
    class API
      include HTTParty
      base_uri 'https://api.wit.ai'

      def message(message)
        self.class.get('/message', {
          :query => { 'q' => message },
          :headers => headers
        })
      end

      def converse(message, session_id:, context:)
        self.class.post('/converse', {
          :headers => headers,
          :query => { 'q' => message, 'session_id' => session_id },
          :body => context.to_json
        })
      end

      def headers
        {
          'Accept' => "application/vnd.wit.#{Dolores.configuration.wit_api_version}+json",
          'Authorization' => "Bearer #{Dolores.configuration.wit_token}",
          'Content-Type' => 'application/json'
        }
      end

    end
  end
end