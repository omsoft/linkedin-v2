module Linkedin
  module V2
    module Entities
      # example response
      # {
      #   "5388341"=> {
      #     "vanityName"=>"mattiaorfano",
      #     "localizedName"=>"Mattia Orfano - Your Rails developer buddy",
      #     "foundedOn"=>{"year"=>2014},
      #     "created"=>{"actor"=>"urn:li:person:t9zD8GQWx2", "time"=>1414398011900},
      #     "groups"=>[],
      #     "organizationStatus"=>"OPERATING",
      #     "organizationType"=>"SELF_EMPLOYED",
      #     "lastModified"=>{"actor"=>"urn:li:person:t9zD8GQWx2", "time"=>1673468224209},
      #     "id"=>5388341,
      #     "localizedDescription"=>"...",
      #     "localizedWebsite"=>"https://mattiaorfano.com",
      #   }
      # }
      #
      # https://learn.microsoft.com/en-us/linkedin/marketing/community-management/organizations/organization-lookup-api
      #
      class People < Entity
        def id
          @object.id
        end

        def urn
          "urn:li:organization:#{@object.id}"
        end

        def name
          @object.localizedName
        end

        def website
          @object.localizedWebsite
        end

        def created_at
          Time.at @object.created.time / 1000
        end
      end
    end
  end
end
