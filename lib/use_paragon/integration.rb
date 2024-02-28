# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/api/users#disconnecting-integrations
  class Integration < Base
    VALID_HTTP_METHODS = %w[post get put patch delete].freeze

    # Returns a list of the integrations enabled for the Paragon project by the ID in the URL.
    def list
      connection.get(path("sdk/integrations"))
    end

    # Get the name, brandColor, and icon, for any of your active integration providers.
    def metadata
      connection.get(path("sdk/metadata"))
    end

    # Call proxy_request to send an API request to a third-party integration on behalf of
    # one of your users
    # https://docs.useparagon.com/api/making-api-requests#server-side-usage
    # This endpoint accepts any HTTP verb you want to use with the API:
    # post, get, put, patch or delete.
    # Body contents must be specified as application/json.
    def proxy_request(request_method, integration_type, integration_path, payload = {})
      formatted_method = request_method&.downcase

      validate_proxy_http_method(formatted_method)

      connection.send(
        formatted_method,
        path("sdk/proxy/#{integration_type}/#{integration_path}"),
        payload
      )
    end

    # Integrations can be disconnected using uninstall via REST API.
    def uninstall(integration_id)
      connection.delete(path("sdk/integrations/#{integration_id}"))
    end

    private

    def validate_proxy_http_method(formatted_method)
      return if VALID_HTTP_METHODS.include?(formatted_method)

      raise ArgumentError,
            "Invalid request method: #{formatted_method}. "  \
            "Allowed methods: #{VALID_HTTP_METHODS.join(", ")}"
    end
  end
end
