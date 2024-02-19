# frozen_string_literal: true

require "logger"

RSpec.describe UseParagon::Configuration do
  let(:configuration) { described_class.new }

  describe "#initialize" do
    it "initializes with no default private_key" do
      expect(configuration.private_key).to be_nil
    end

    it "initializes with no default project_id" do
      expect(configuration.project_id).to be_nil
    end

    it "initializes with default base_url" do
      expect(configuration.base_url).to eq("https://zeus.useparagon.com")
    end

    it "initializes with default logger" do
      expect(configuration.logger).to be_a(Logger)
    end

    it "initializes with default logger_enabled" do
      expect(configuration.logger_enabled).to be(true)
    end
  end

  describe "attributes" do
    it "allows setting and getting private_key" do
      configuration.private_key = "some_key"
      expect(configuration.private_key).to eq("some_key")
    end

    it "allows setting and getting project_id" do
      configuration.project_id = "some_id"
      expect(configuration.project_id).to eq("some_id")
    end

    it "allows setting and getting base_url" do
      configuration.base_url = "http://example.com"
      expect(configuration.base_url).to eq("http://example.com")
    end

    it "allows setting and getting logger" do
      default_logger = configuration.logger
      configured_logger = Logger.new(STDOUT)
      configuration.logger = configured_logger

      expect(configuration.logger).to eq(configured_logger)
      expect(default_logger).not_to eq(configured_logger)
    end

    it "allows setting and getting logger_enabled" do
      configuration.logger_enabled = false
      expect(configuration.logger_enabled).to be(false)
    end
  end
end
