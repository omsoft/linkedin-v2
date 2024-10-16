module Linkedin
  module V2
    class API::Post < API
      def create(organization_urn, body, attachment = {})
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

        if attachment.present?
          schema["content"] = {
            "media": {
              "title": attachment["title"],
              "id": attachment["id"]
            }
          }
        end

        response = post("posts", schema.to_json)
      end
    end
  end
end
