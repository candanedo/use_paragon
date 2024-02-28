# frozen_string_literal: true

require "use_paragon/base"

module UseParagon
  # API calls for workflows
  class Workflow < Base
    def request(workflow_id, payload = {})
      connection.post(path("sdk/triggers/#{workflow_id}"), payload)
    end

    def event(event_name, payload = {})
      connection.post(path("sdk/events/trigger"), event_payload(event_name, payload))
    end

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
