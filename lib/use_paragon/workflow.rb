# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/workflows/triggers#request
  class Workflow < Base
    # The Request trigger can be used to run workflows by sending it an HTTP request
    def request(workflow_id, payload = {})
      endpoint = path("sdk/triggers/#{workflow_id}")

      connection.post(endpoint, payload).body
    end

    # Call request to send an API request to a third-party integration on behalf of
    # one of your users
    # https://docs.useparagon.com/api/api-reference#request-integrationtype-string-path-string-requestoptions-requestinit-promise-less-than-unknown-gre
    # ptions: Request options to include, such as:
    # body: An object representing JSON contents of the request.
    # method: An HTTP verb such as "GET" or "POST". Defaults to GET.
    def proxy_request(integration_type, third_party_path, options)
      endpoint = path("sdk/proxy/#{integration_type}/#{third_party_path}")

      connection.post(endpoint, options).body
    end

    # App Events can be sent from your application using the Paragon REST API.
    def event(event_name, payload = {})
      endpoint = path("sdk/events/trigger")

      connection.post(endpoint, event_payload(event_name, payload)).body
    end

    # Call disable Workflow to turn off a workflow for a user by ID.
    def disable(workflow_id)
      endpoint = path("sdk/workflows/#{workflow_id}")

      connection.delete(endpoint).body
    end

    private

    def event_payload(event_name, payload)
      {
        name: event_name,
        payload: payload
      }
    end
  end
end
