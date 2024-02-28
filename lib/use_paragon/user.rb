# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/api/api-reference#getuser-paragonuser
  # Retrieve the currently authenticated user and their connected integration state
  class User < Base
    def get
      connection.get(path("sdk/me"))
    end

    def metadata=(metadata)
      connection.patch(path("sdk/me"), metadata)
    end

    def credentials
      connection.get(path("sdk/credentials"))
    end
  end
end
