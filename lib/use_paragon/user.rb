# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/api/api-reference#getuser-paragonuser
  # Retrieve the currently authenticated user and their connected integration state
  class User < Base
    def get
      endpoint = path("sdk/me")

      connection.get(endpoint).body
    end

    # Call set_metadata to associate the authenticated user with metadata from
    # your application
    # { "meta": { "Email": "sean@useparagon.com", "apiKey": "key_Y0kBVldPFInxK" } }
    def metadata=(metadata)
      endpoint = path("sdk/me")

      connection.patch(endpoint, metadata).body
    end

    def credentials
      endpoint = path("sdk/credentials")

      connection.get(endpoint).body
    end
  end
end
