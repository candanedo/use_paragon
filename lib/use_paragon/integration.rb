# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/api/users#disconnecting-integrations
  class Integration < Base
    VALID_HTTP_METHODS = %w[post get put patch delete].freeze

    def list
      connection.get(path("sdk/integrations"))
    end

    def metadata
      connection.get(path("sdk/metadata"))
    end

    def proxy_request(request_method, integration_type, integration_path, payload = {})
      formatted_method = request_method&.downcase

      validate_proxy_http_method(formatted_method)

      connection.send(
        formatted_method,
        path("sdk/proxy/#{integration_type}/#{integration_path}"),
        payload
      )
    end

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
