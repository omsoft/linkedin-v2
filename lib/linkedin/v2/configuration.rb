module Linkedin
  module V2
    # Configuration for the LinkedIn V2 gem.
    #
    #     LinkedIn::V2.configure do |config|
    #       config.client_id     = ENV["LINKEDIN_CLIENT_ID"]
    #       config.client_secret = ENV["LINKEDIN_CLIENT_SECRET"]
    #     end
    #
    # The default endpoints for LinkedIn are also stored here.
    #
    class Configuration
      attr_accessor :api_url,
                    :api_version,
                    :site,
                    :scope,
                    :redirect_uri,
                    :client_id,
                    :client_secret,
                    :token_endpoint,
                    :authorization_endpoint

      def initialize
        @api_url = "https://api.linkedin.com"
        @api_version = "/rest"
        @site = "https://www.linkedin.com"
        @token_endpoint = "/oauth/v2/accessToken"
        @authorization_endpoint = "/oauth/v2/authorization"
      end
    end
  end
end
