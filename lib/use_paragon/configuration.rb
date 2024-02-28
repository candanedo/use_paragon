# frozen_string_literal: true

module UseParagon
  # Allows configuration using an initializer
  class Configuration
    attr_accessor :private_key, :project_id, :base_url, :logger, :logger_enabled

    def initialize
      @base_url = "https://zeus.useparagon.com"
      @logger = Logger.new(STDOUT)
      @logger_enabled = true
    end
  end
end
