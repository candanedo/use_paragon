# frozen_string_literal: true

RSpec.describe UseParagon::User do
  let(:user) { described_class.new(123) }

  describe "#get" do
    it "calls the correct endpoint" do
      expect(user).to receive(:path).with("sdk/me").and_return("/projects/123/sdk/me")
      expect(user).to receive(:connection).and_return(double("connection", get: true))
      user.get
    end
  end

  describe "#metadata=" do
    it "calls the correct endpoint with patch method" do
      expect(user).to receive(:path).with("sdk/me").and_return("/projects/123/sdk/me")
      expect(user).to receive(:connection).and_return(double("connection", patch: true))
      user.metadata = {}
    end
  end

  describe "#credentials" do
    it "calls the correct endpoint" do
      expect(user).to receive(:path).with("sdk/credentials")
                                    .and_return("/projects/123/sdk/credentials")
      expect(user).to receive(:connection).and_return(double("connection", get: true))
      user.credentials
    end
  end
end
