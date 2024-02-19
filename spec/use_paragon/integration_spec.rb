# frozen_string_literal: true

RSpec.describe UseParagon::Integration do
  let(:integration) { described_class.new(123) }

  describe "#metadata" do
    it "calls the correct endpoint" do
      expect(integration).to receive(:path).with("sdk/metadata")
                                           .and_return("/projects/123/sdk/metadata")
      expect(integration).to receive(:connection)
        .and_return(double("connection", get: true))
      integration.metadata
    end
  end

  describe "#list" do
    it "calls the correct endpoint" do
      expect(integration).to receive(:path).with("sdk/integrations")
                                           .and_return("/projects/123/sdk/integrations")
      expect(integration).to receive(:connection)
        .and_return(double("connection", get: true))
      integration.list
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
