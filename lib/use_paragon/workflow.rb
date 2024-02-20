# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/workflows/triggers#request
  class Workflow < Base
    VALID_HTTP_METHODS = %w[post get put patch delete].freeze
    # The Request trigger can be used to run workflows by sending it an HTTP request
    def request(workflow_id, payload = {})
      endpoint = path("sdk/triggers/#{workflow_id}")

      connection.post(endpoint, payload)
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

      endpoint = path("sdk/proxy/#{integration_type}/#{integration_path}")

      connection.send(formatted_method, endpoint, payload)
    end

    # App Events can be sent from your application using the Paragon REST API.
    def event(event_name, payload = {})
      endpoint = path("sdk/events/trigger")

      connection.post(endpoint, event_payload(event_name, payload))
    end

    # Call disable Workflow to turn off a workflow for a user by ID.
    def disable(workflow_id)
      endpoint = path("sdk/workflows/#{workflow_id}")

      connection.delete(endpoint)
    end

    private

    def event_payload(event_name, payload)
      {
        name: event_name,
        payload: payload
      }
    end

    def validate_proxy_http_method(formatted_method)
      return if VALID_HTTP_METHODS.include?(formatted_method)

      raise ArgumentError,
            "Invalid request method: #{formatted_method}. "  \
            "Allowed methods: #{VALID_HTTP_METHODS.join(", ")}"
    end
  end
end
