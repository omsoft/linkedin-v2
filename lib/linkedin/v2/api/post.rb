module Linkedin
  module V2
    class API::Post < API
      # Creates a Post with image or video assets.
      #
      # * organization_urn is URN of the author of the content (eg. urn:li:organization:5515715)
      # * body is the commentary of the post being published
      # * attachments is a collection of asset urns (eg. urn:li:video:C5F10AQGKQg_6y2a4sQ)
      #
      def create(organization_urn, body, attachments = [])
        schema = {
          "author": organization_urn,
          "commentary": body,
          "visibility": "PUBLIC",
          "distribution": {
            "feedDistribution": "MAIN_FEED",
            "targetEntities": [],
            "thirdPartyDistributionChannels": []
          },
          "lifecycleState": "PUBLISHED",
          "isReshareDisabledByAuthor": false
        }

        if attachments.size > 1
          schema["content"] = {
            "multiImage": {
              "images": attachments.map { |id| { id: } }
            }
          }
        elsif attachments.size == 1
          schema["content"] = {
            "media": { "id": attachments[0] }
          }
        end

        post("posts", schema.to_json)
      end
    end
  end
end
