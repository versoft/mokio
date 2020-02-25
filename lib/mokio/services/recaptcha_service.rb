module Mokio
  module Services #:nodoc:
    class RecaptchaService

      require 'net/http'
      require 'uri'
      require 'json'

      extend ActiveSupport::Concern
      attr_accessor :user_token

      def initialize(user_token)
        @user_token = user_token
      end

      def call
        if Mokio.mokio_login_with_recaptcha
          secret = Mokio.mokio_login_recaptcha_secret_key
          uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret}&response=#{@user_token}")
          response = Net::HTTP.get_response(uri)
          json = JSON.parse(response.body)
          response_is_valid? json
        else
          true
        end
      end

      private

      def response_is_valid?(data)
        return false if data['score'].blank?
        data['success'] &&
        data['score'] >= score &&
        data['action'] == 'login'
      end

      def score
        value_config = Mokio.mokio_login_recaptcha_score
        if value_config.is_a? Numeric
          value = value_config
        else
          value = value_config.gsub(",",".").to_f
        end
        if value > 1 || value < 0
          raise "Invalid reCAPTCHA score"
        else
          value
        end
      end
    end
  end
end
