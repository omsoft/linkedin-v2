module Linkedin
  module V2
    class API::Video < API
      # Uploads a Video to Linkedin and returns its own unique asset URN
      def upload(organization_urn, path, content_type)
        asset_urn, upload_urls = initialize_upload(organization_urn, File.size(path))

        tags = etags(path, upload_urls)
        finalize_upload(asset_urn, tags)
        wait_upload(asset_urn)

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

      def chunks(path, chunk_size)
        file = File.open(path, "rb")

        f_bytes = []
        f_bytes.push(file.read(chunk_size)) until file.eof?
        f_bytes
      ensure
        file.close
      end

      def etags(path, upload_urls)
        f_bytes = chunks(path, 4_194_304)

        upload_urls.map.with_index do |upload_url, index|
          response = put(
            upload_url['uploadUrl'],
            f_bytes[index],
            { "Content-Type": "application/octet-stream" }
          )

          response.headers["etag"] # if response.headers["etag"].present?
        end.compact
      end

      # Declares the upcoming upload for the specified organization URN,
      # and fetch upload instructions for each file chunk.
      def initialize_upload(organization_urn, file_size)
        payload = {
          initializeUploadRequest: {
            owner: organization_urn,
            fileSizeBytes: file_size,
            uploadCaptions: false,
            uploadThumbnail: false
          }
        }
        response = post("videos?action=initializeUpload", payload.to_json)

        asset_urn = response.dig('value', 'video')
        upload_urls = response.dig('value', 'uploadInstructions')

        [asset_urn, upload_urls]
      end

      def finalize_upload(asset_urn, etags)
        payload = {
          finalizeUploadRequest: {
            video: asset_urn,
            uploadToken: "",
            uploadedPartIds: etags
          }
        }
        post("videos?action=finalizeUpload", payload.to_json)
      end

      def wait_upload(asset_urn)
        retries = 0
        loop do
          response = get("videos/#{CGI.escape(asset_urn)}")
          retries += 1

          puts response
          break if response.status == "AVAILABLE" || retries >= 3
          sleep(5)
        end
      end
    end
  end
end
