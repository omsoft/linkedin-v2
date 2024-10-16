module Linkedin
  module V2
    module Entities
      # example response
      # {
      #   "lifecycleState": "PUBLISHED",
      #   "lastModifiedAt": 1634790968774,
      #   "visibility": "PUBLIC",
      #   "publishedAt": 1634790968774,
      #   "author": "urn:li:organization:5515715",
      #   "distribution": {
      #     "feedDistribution": "NONE",
      #     "thirdPartyDistributionChannels": []
      #   },
      #   "content": {
      #     "media": {
      #       "id": "urn:li:video:C5F10AQGKQg_6y2a4sQ"
      #     }
      #   },
      #   "lifecycleStateInfo": {
      #     "isEditedByAuthor": false
      #   },
      #   "isReshareDisabledByAuthor": false,
      #   "createdAt": 1634790968743,
      #   "id": "urn:li:ugcPost:6856810298419044352",
      #   "commentary": "comment on Oct 20",
      # }
      #
      # https://learn.microsoft.com/en-us/linkedin/marketing/community-management/shares/posts-api
      #
      class Post < Entity
        def id
          @object.id
        end

        def body
          @object.commentary
        end

        def author
          @object.author
        end

        def visibility
          @object.visibility
        end

        def published_at
          Time.at(@object.publishedAt / 1000)
        end

        def created_at
          Time.at(@object.createdAt / 1000)
        end

        def updated_at
          Time.at(@object.lastModifiedAt / 1000)
        end
      end
    end
  end
end
