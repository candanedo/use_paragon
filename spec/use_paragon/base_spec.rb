# frozen_string_literal: true

RSpec.describe UseParagon::Base do
  let(:user_id) { 123 }
  let(:base_instance) { described_class.new(user_id) }

  before do
    # Set up the configuration for testing
    UseParagon.configure do |config|
      config.private_key = File.read(random_private_key_path)
      config.project_id = "test_project_id"
    end
  end

  describe "#initialize" do
    it "initializes with a user_id" do
      expect(base_instance.user_id).to eq(user_id)
    end
  end

  describe "#generate_token" do
    it "raises an error when user_id is nil" do
      expect do
        described_class.new(nil).generate_token
      end.to raise_error(UseParagon::InvalidUserIdError)
    end

    it "raises an error when user_id is blank" do
      expect do
        described_class.new("").generate_token
      end.to raise_error(UseParagon::InvalidUserIdError)
    end

    it "generates a valid JWT token when user is valid" do
      token = base_instance.generate_token
      expect(token).not_to be_nil
    end
  end

  describe "#connection" do
    it "creates a Faraday connection with correct configuration" do
      connection = base_instance.send(:connection)
      expect(connection).to be_a(Faraday::Connection)
      expect(connection.url_prefix.to_s).to eq("#{UseParagon.configuration.base_url}/")
      expect(connection.builder.handlers).to include(Faraday::Request::Authorization)
      expect(connection.builder.handlers).to include(Faraday::Response::Logger)
    end
  end

  describe "#path" do
    it "returns the correct endpoint path" do
      endpoint = "some/random/endpoint"
      expected_path = "/projects/test_project_id/#{endpoint}"

      expect(base_instance.send(:path, endpoint)).to eq(expected_path)
    end
  end

  def random_private_key_path
    File.expand_path("../fixtures/random_private_key.pem", __dir__)
  end
end
