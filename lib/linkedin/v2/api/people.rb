module Linkedin
  module V2
    class API::People < API
      # Retrieve the current member's profile based on the access token.
      #   example response
      #   {
      #     "localizedLastName"=>"Orfano",
      #     "profilePicture"=>{"displayImage"=>"urn:li:digitalmediaAsset:C4E03AQFUVwGIqgzNGw"},
      #     "firstName"=>{"localized"=>{"en_US"=>"Mattia", "it_IT"=>"Mattia"}, "preferredLocale"=>{"country"=>"US", "language"=>"en"}},
      #     "lastName"=>{"localized"=>{"en_US"=>"Orfano", "it_IT"=>"Orfano"}, "preferredLocale"=>{"country"=>"US", "language"=>"en"}},
      #     "id"=>"t9zD8GQWx2",
      #     "localizedFirstName"=>"Mattia"
      #   }
      def me(options = {})
        get("me", {}, options)
      end
    end
  end
end
