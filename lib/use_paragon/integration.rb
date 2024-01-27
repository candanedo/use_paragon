# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/api/users#disconnecting-integrations
  class Integration < Base
    # Get the name, brandColor, and icon, for any of your active integration providers.
    def metadata
      endpoint = path("sdk/metadata")

      connection.get(endpoint).body
    end

    # Returns a list of the integrations enabled for the Paragon project by the ID in the URL.
    def list
      endpoint = path("sdk/integrations")

      connection.get(endpoint).body
    end

    # Integrations can be disconnected using uninstall via REST API.
    def uninstall(integration_id)
      endpoint = path("/sdk/integrations/#{integration_id}")

      connection.delete(endpoint).body
    end
  end
end
