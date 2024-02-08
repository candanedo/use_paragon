# frozen_string_literal: true

require "jwt"
require "faraday"
require "use_paragon/configuration"

module UseParagon
  # Basic logic for interacting with UseParagon platform
  class Base
    attr_reader :token, :user_id

    def initialize(user_id)
      @user_id = user_id
      @token = nil
    end

    def generate_token
      validate_user_id!

      rsa_private = OpenSSL::PKey::RSA.new(private_key)
      created_at = Time.now.floor.to_i

      payload = {
        sub: user_id,
        iat: created_at,
        exp: created_at + 60 * 60
      }

      @token = JWT.encode payload, rsa_private, "RS256"
    end

    private

    def base_url
      "https://zeus.useparagon.com"
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.request :authorization, "Bearer", generate_token
        conn.response :logger, Rails.logger, { errors: true, bodies: true }

        conn.url_prefix = base_url
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.response :raise_error
      end
    end

    def logger(conn)
      conn.response :logger, Rails.logger, { errors: true, bodies: true } do |logger|
        logger.filter(/(Authorization:)([^&]+)/, '\1[REMOVED]')
        logger.filter(/("code":)([^&]+)/, '\1[REMOVED]')
      end
    end

    def logger_enabled?
      ENV.fetch("USEPARAGON_API_LOGGER", "false") == "true"
    end

    def path(endpoint)
      "/projects/#{project_id}/#{endpoint}"
    end

    def private_key
      UseParagon.configuration.private_key
    end

    def project_id
      UseParagon.configuration.project_id
    end

    def validate_user_id!
      raise UseParagon::InvalidUserIdError if user_id.nil? || user_id.to_s.empty?
    end
  end
end
