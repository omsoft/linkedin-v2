module Linkedin
  module V2
    class API::Organization < API
      # Fetch a list of organization acls where the authenticated member has the approved role of ADMINISTRATOR.
      def acls(options = {})
        response = get(
          "organizationAcls",
          {
            q: "roleAssignee",
            role: "ADMINISTRATOR",
            state: "APPROVED"
          },
          { "X-Restli-Protocol-Version": "2.0.0" }
        )

        response.fetch('elements', [])
                .map { |acl| Entities::OrganizationAcl.new(acl) }
      end

      # Fetch a list of organizations where the authenticated member has the approved role of ADMINISTRATOR.
      def list(options = {})
        organization_ids = acls.map(&:organization_id).join(",")
        response = get(
          "organizations",
          { ids: "List(#{organization_ids})" }
        )

        response.fetch('results', {})
                .map { |id, organization| Entities::Organization.new(organization) }
      end
    end
  end
end
