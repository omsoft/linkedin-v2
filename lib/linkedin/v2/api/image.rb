module Linkedin
  module V2
    class API::Image < API
      # Uploads an Image to Linkedin and returns its own unique asset URN
      def upload(organization_urn, path, content_type)
        response = initialize_upload(organization_urn)
        upload_url = response.dig('value', 'uploadUrl')
        asset_urn = response.dig('value', 'image')

        if File.exist?(path)
          File.open(path, 'rb') do |file|
            payload = { file: Faraday::Multipart::FilePart.new(file, content_type) }
            put(upload_url, payload)
          end
        end

        asset_urn
      end

      private

      # The default connection setup must be overwritten to ensure multipart requests.
      def connection
        Faraday.new(
          url:,
          params: default_params,
          headers: {
            "Linkedin-Version" => ENV.fetch("LINKEDIN_API_VERSION", "202409"),
            "X-Restli-Protocol-Version" => "2.0.0",
            "Authorization" => "Bearer #{@access_token}"
          }
        ) do |f|
          f.request :multipart
        end
      end

      # Declares the upcoming upload for the specified organization URN,
      # and fetch the upload URL to upload the image.
      def initialize_upload(organization_urn)
        payload = {
          initializeUploadRequest: {
            owner: organization_urn
          }
        }
        post("images?action=initializeUpload", payload.to_json)
      end
    end
  end
end
