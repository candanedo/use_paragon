# frozen_string_literal: true

RSpec.describe UseParagon::Workflow do
  let(:workflow) { described_class.new(123) }

  describe "#request" do
    it "calls the correct endpoint with post method" do
      expect(workflow).to receive(:path).with("sdk/triggers/789")
                                        .and_return("/projects/123/sdk/triggers/789")
      expect(workflow).to receive(:connection).and_return(double("connection", post: true))
      workflow.request(789)
    end
  end

  describe "#proxy_request" do
    context "with valid HTTP method" do
      it "calls the correct endpoint with post method" do
        expect(workflow).to receive(:path).with("sdk/proxy/some_type/some_path")
                                          .and_return("/projects/123/sdk/proxy/some_type/some_path")
        expect(workflow).to receive(:connection).and_return(double("connection", post: true))
        workflow.proxy_request("post", "some_type", "some_path", {})
      end

      it "calls the correct endpoint with delete method" do
        expect(workflow).to receive(:path).with("sdk/proxy/some_type/some_path")
                                          .and_return("/projects/123/sdk/proxy/some_type/some_path")
        expect(workflow).to receive(:connection).and_return(double("connection", delete: true))
        workflow.proxy_request("delete", "some_type", "some_path", {})
      end
    end

    context "with invalid HTTP method" do
      it "raises ArgumentError" do
        expect { workflow.proxy_request("invalid_method", "some_type", "some_path", {}) }
          .to raise_error(ArgumentError, /Invalid request method/)
      end
    end

    context "with missing HTTP method" do
      it "raises ArgumentError" do
        expect { workflow.proxy_request(nil, "some_type", "some_path", {}) }
          .to raise_error(ArgumentError, /Invalid request method/)
      end
    end
  end

  describe "#event" do
    it "calls the correct endpoint with post method" do
      expect(workflow).to receive(:path).with("sdk/events/trigger")
                                        .and_return("/projects/123/sdk/events/trigger")
      expect(workflow).to receive(:connection).and_return(double("connection", post: true))
      workflow.event("some_event", {})
    end
  end

  describe "#disable" do
    it "calls the correct endpoint with delete method" do
      expect(workflow).to receive(:path).with("sdk/workflows/abc")
                                        .and_return("/projects/123/sdk/workflows/abc")
      expect(workflow).to receive(:connection).and_return(double("connection", delete: true))
      workflow.disable("abc")
    end
  end
end
