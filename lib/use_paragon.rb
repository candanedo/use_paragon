# frozen_string_literal: true

require "use_paragon/configuration"
require "use_paragon/base"
require "use_paragon/integration"
require "use_paragon/user"
require "use_paragon/version"
require "use_paragon/workflow"

module UseParagon
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure(&block)
      yield(configuration)
    end
  end

  class Error < StandardError; end
  class InvalidUserIdError < StandardError; end
end
