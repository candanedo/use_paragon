# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # https://docs.useparagon.com/workflows/triggers#request
  class Workflow < Base
    # The Request trigger can be used to run workflows by sending it an HTTP request
    def request(workflow_id, payload = {})
      connection.post(path("sdk/triggers/#{workflow_id}"), payload)
    end

    # App Events can be sent from your application using the Paragon REST API.
    def event(event_name, payload = {})
      connection.post(path("sdk/events/trigger"), event_payload(event_name, payload))
    end

    # Call disable Workflow to turn off a workflow for a user by ID.
    def disable(workflow_id)
      connection.delete(path("sdk/workflows/#{workflow_id}"))
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
