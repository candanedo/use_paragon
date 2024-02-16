# frozen_string_literal: true

require "faraday"
require "jwt"

module UseParagon
  # Basic logic for interacting with UseParagon platform
  # Handles authentication and requests to Paragon API base on:
  # https://docs.useparagon.com/getting-started/installing-the-connect-sdk#setup-with-your-own-authentication-backend
  class Base
    attr_reader :token, :user_id

    def initialize(user_id)
      @user_id = user_id
      @token = nil
    end

    def generate_token
      # Paragon User Token for each of your authenticated user
      validate_user_id!

      rsa_private = OpenSSL::PKey::RSA.new(config.private_key)
      created_at = Time.now.floor.to_i

      payload = {
        sub: user_id,
        iat: created_at,
        exp: created_at + 60 * 60
      }

      @token = JWT.encode payload, rsa_private, "RS256"
    end

    private

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = config.base_url
        conn.request :authorization, "Bearer", generate_token
        conn.request :json

        if config.logger_enabled
          conn.response :logger, config.logger, { errors: true, bodies: true }
        end

        conn.response :json, content_type: "application/json"
        conn.response :raise_error
      end
    end

    def path(endpoint)
      "/projects/#{config.project_id}/#{endpoint}"
    end

    def validate_user_id!
      raise UseParagon::InvalidUserIdError if user_id.nil? || user_id.to_s.empty?
    end

    def config
      UseParagon.configuration
    end
  end
end
