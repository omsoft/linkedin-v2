# frozen_string_literal: true

require_relative "v2/version"
require_relative "v2/configuration"

require "hashie"
require "faraday"
require "faraday/multipart"

# general purpose custom libraries
require_relative "v2/connection"
require_relative "v2/faraday"

# entities representation
require_relative "v2/entities/entity"
require_relative "v2/entities/organization_acl"
require_relative "v2/entities/organization"
require_relative "v2/entities/people"
require_relative "v2/entities/post"

# apis
require_relative "v2/api"
require_relative "v2/api/article"
require_relative "v2/api/image"
require_relative "v2/api/organization"
require_relative "v2/api/people"
require_relative "v2/api/post"
require_relative "v2/api/video"

module Linkedin
  module V2
    # class Error < StandardError; end

    @config = Linkedin::V2::Configuration.new

    class << self
      attr_accessor :config
    end

    def self.configure
      yield config
    end
  end
end
