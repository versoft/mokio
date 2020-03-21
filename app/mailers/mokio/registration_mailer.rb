module Mokio
  class RegistrationMailer < ActionMailer::Base
    default from: Devise.mailer_sender

    def send_pass_setup_instruction(obj, token)
      @obj = obj
      @email = obj.email
      @token = token

      headers = {
        subject: I18n.t('registration_mailer.title'),
        to: @email,
        from: Devise.mailer_sender
      }

      mail(headers)
    end
  end
end
