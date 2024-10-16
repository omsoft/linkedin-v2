module Linkedin
  module V2
    class API
      include Connection

      attr_accessor :access_token

      def initialize(access_token=nil)
        @access_token = access_token
      end

      private

      # Make sure to use versioned APIs: https://learn.microsoft.com/en-us/linkedin/marketing/versioning
      def default_headers
        {
          "Content-Type" => "application/json",
          "Linkedin-Version" => ENV.fetch("LINKEDIN_API_VERSION", "202409"),
          "X-Restli-Protocol-Version" => "2.0.0",
          "Authorization" => "Bearer #{@access_token}"
        }
      end

      # default query parameters
      def default_params
        {}
      end

      # base api url
      def url
        Linkedin::V2.config.api_url + Linkedin::V2.config.api_version
      end
    end
  end
end
