# frozen_string_literal: true

require "use_paragon/configuration"
require "use_paragon/base"
require "use_paragon/integration"
require "use_paragon/user"
require "use_paragon/version"
require "use_paragon/workflow"

# UseParagon gem base module
module UseParagon
  # Configuration from initializer
  class << self
    def load!
      register_rails_engine if rails?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def register_rails_engine
      require "use_paragon/engine"
    end
  end

  class Error < StandardError; end
  class InvalidUserIdError < StandardError; end
end
