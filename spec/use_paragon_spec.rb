# frozen_string_literal: true

RSpec.describe UseParagon do
  it "has a version number" do
    expect(UseParagon::VERSION).not_to be nil
  end

  describe ".configuration" do
    it "returns a configuration object" do
      expect(UseParagon.configuration).to be_an_instance_of(UseParagon::Configuration)
    end
  end

  describe ".configure" do
    it "yields the configuration object" do
      expect { |block| UseParagon.configure(&block) }.to yield_with_args(UseParagon.configuration)
    end

    it "allows overriding base_url through configure block" do
      custom_url = "https://paragon.mycompany.com"

      UseParagon.configure do |config|
        config.base_url = custom_url
      end

      expect(UseParagon.configuration.base_url).to eq(custom_url)
      expect(UseParagon.configuration.base_url).not_to eq("https://zeus.useparagon.com")
    end
  end
end
