module Mokio
  module Concerns
    module Models
      #
      # Concern for Mailer model
      #
      module Mailer
        extend ActiveSupport::Concern

        included do
          include ActiveModel::Model

          attr_accessor :name, :email, :title, :message, :recipients, :template

          validates :email,   presence: true
          validates :message, presence: true
        end

        #
        # Returns email template in html, replacing as follows:
        # 1. %name% to object.name
        # 2. %email% to object.email
        # 3. %title% to object.title
        # 4. %message% to object.message
        #
        def template_msg
          self.template.gsub('%name%', self.name).gsub('%email%', self.email).gsub('%title%', self.title).gsub('%message%', self.message).html_safe
        end
      end
    end
  end
end