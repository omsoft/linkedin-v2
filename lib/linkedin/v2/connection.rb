module Linkedin
  module V2
    module Connection
      class Response < Hashie::Mash; end
      class APIError < StandardError
        attr_reader :status

        def initialize(status, body)
          @status = status
          super(body)
        end
      end

      protected

      def connection
        @connection ||= Faraday.new(
          url:,
          params: default_params,
          headers: default_headers,
          request: request_options
        )
      end

      def get(path, params={}, options={})
        response = connection.get(path, params, options)

        if response.status == 200
          parsed = JSON.parse(response.body)
          Response.new(parsed)
        else
          raise APIError.new(response.status, response.body)
        end
      end

      def post(path, params={}, options={})
        response = connection.post(path, params, options)

        case response.status
        when 200
          parsed = JSON.parse(response.body)
          Response.new(parsed)
        when 201
          # if body empty, return response headers where Linkedin usually sets x-restli-id
          response.body.present? ? response.body : response.headers
        else
          raise APIError.new(response.status, response.body)
        end
      end

      private

      def request_options
        { params_encoder: Faraday::FlatParamsEncoder }
      end

      # Make sure to use versioned APIs: https://learn.microsoft.com/en-us/linkedin/marketing/versioning
      def default_headers
        raise "Not implemented!"
      end

      # default query parameters
      def default_params
        raise "Not implemented!"
      end

      # base api url
      def url
        raise "Not implemented!"
      end
    end
  end
end
