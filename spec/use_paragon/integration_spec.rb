# frozen_string_literal: true

RSpec.describe UseParagon::Integration do
  let(:integration) { described_class.new(123) }

  describe "#list" do
    it "calls the correct endpoint" do
      expect(integration).to receive(:path).with("sdk/integrations")
                                           .and_return("/projects/123/sdk/integrations")
      expect(integration).to receive(:connection)
        .and_return(double("connection", get: true))
      integration.list
    end
  end

  describe "#metadata" do
    it "calls the correct endpoint" do
      expect(integration).to receive(:path).with("sdk/metadata")
                                           .and_return("/projects/123/sdk/metadata")
      expect(integration).to receive(:connection)
        .and_return(double("connection", get: true))
      integration.metadata
    end
  end

  describe "#proxy_request" do
    context "with valid HTTP method" do
      it "calls the correct endpoint with post method" do
        expect(integration).to receive(:path).with("sdk/proxy/some_type/some_path")
                                             .and_return(
                                               "/projects/123/sdk/proxy/some_type/some_path"
                                             )
        expect(integration).to receive(:connection).and_return(double("connection", post: true))
        integration.proxy_request("post", "some_type", "some_path", {})
      end

      it "calls the correct endpoint with delete method" do
        expect(integration).to receive(:path).with("sdk/proxy/some_type/some_path")
                                             .and_return(
                                               "/projects/123/sdk/proxy/some_type/some_path"
                                             )
        expect(integration).to receive(:connection).and_return(double("connection", delete: true))
        integration.proxy_request("delete", "some_type", "some_path", {})
      end
    end

    context "with invalid HTTP method" do
      it "raises ArgumentError" do
        expect { integration.proxy_request("invalid_method", "some_type", "some_path", {}) }
          .to raise_error(ArgumentError, /Invalid request method/)
      end
    end

    context "with missing HTTP method" do
      it "raises ArgumentError" do
        expect { integration.proxy_request(nil, "some_type", "some_path", {}) }
          .to raise_error(ArgumentError, /Invalid request method/)
      end
    end
  end

  describe "#uninstall" do
    it "calls the correct endpoint" do
      expect(integration).to receive(:path).with("sdk/integrations/456")
                                           .and_return("/projects/123/sdk/integrations/456")
      expect(integration).to receive(:connection)
        .and_return(double("connection", delete: true))
      integration.uninstall(456)
    end
  end
end
