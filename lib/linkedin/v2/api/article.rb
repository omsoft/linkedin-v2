module Linkedin
  module V2
    class API::Article < API
      def create(organization_urn, title, body)
        schema = {
          "author": organization_urn,
          "commentary": title,
          "visibility": "PUBLIC",
          "distribution": {
            "feedDistribution": "MAIN_FEED",
            "targetEntities": [],
            "thirdPartyDistributionChannels": []
          },
          "content": {
            "article": {
              "source": "https://lnkd.in/eabXpqi",
              # "thumbnail": "urn:li:image:C49klciosC89",
              "title": title,
              "description": body
            }
          },
          "lifecycleState": "PUBLISHED",
          "isReshareDisabledByAuthor": false
        }

        response = post("posts", schema.to_json)
      end
    end
  end
end
