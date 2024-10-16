module Linkedin
  module V2
    module Entities
      #   example response
      #   {
      #       "roleAssignee": "urn:li:person:t9zD8GQWx2",
      #       "state": "APPROVED",
      #       "lastModified": {
      #           "actor": "urn:li:person:t9zD8GQWx2",
      #           "time": 1414398011900
      #       },
      #       "role": "ADMINISTRATOR",
      #       "created": {
      #           "actor": "urn:li:person:t9zD8GQWx2",
      #           "time": 1414398011900
      #       },
      #       "organization": "urn:li:organization:5388341"
      #   }
      #
      # https://learn.microsoft.com/en-us/linkedin/marketing/community-management/organizations/organization-access-control-by-role
      #
      class OrganizationAcl < Entity
        # for eg. 5388341
        def organization_id
          organization_urn.split(":")[-1]
        end

        # for eg. urn:li:organization:5388341
        def organization_urn
          @object.organization
        end

        def created_at
          Time.at @object.created.time / 1000
        end
      end
    end
  end
end
