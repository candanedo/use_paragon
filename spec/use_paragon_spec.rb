# frozen_string_literal: true

RSpec.describe UseParagon do
  it "has a version number" do
    expect(UseParagon::VERSION).not_to be nil
  end

  describe ".load!" do
    context "when running in a Rails environment" do
      it "registers Rails engine" do
        allow(UseParagon).to receive(:rails?).and_return(true)
        expect(UseParagon).to receive(:register_rails_engine)
        UseParagon.load!
      end
    end

    context "when not running in a Rails environment" do
      it "does not register Rails engine" do
        allow(UseParagon).to receive(:rails?).and_return(false)
        expect(UseParagon).not_to receive(:register_rails_engine)
        UseParagon.load!
      end
    end
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
  end

  # Investigate why this test is failing
  describe ".load!" do
    context "when Rails is present" do
      before do
        allow(UseParagon).to receive(:rails?).and_return(true)
      end

      it "registers the Rails engine" do
        expect(UseParagon).to receive(:register_rails_engine)
        UseParagon.load!
      end
    end

    context "when Rails is not present" do
      before do
        allow(UseParagon).to receive(:rails?).and_return(false)
      end

      it "does not register the Rails engine" do
        expect(UseParagon).not_to receive(:register_rails_engine)
        UseParagon.load!
      end
    end
  end
end
