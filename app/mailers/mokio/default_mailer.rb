module Mokio
  class DefaultMailer < ActionMailer::Base
    default from: "from@example.com"

    def msg(obj)
      @mailer = obj

      mail(to: @mailer.recipients)
    end
  end
end
