# frozen_string_literal: true

module UseParagon
  # Allows configuration using an initializer
  class Configuration
    attr_accessor :private_key, :project_id, :base_url

    def initialize
      @base_url = "https://zeus.useparagon.com"
    end
  end
end
