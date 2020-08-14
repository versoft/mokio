module Mokio
  module Concerns
    module Models
      #
      # Concern for Contact model
      #
      module Contact
        extend ActiveSupport::Concern

        included do
          has_many :recipients, dependent: :destroy
          has_one :contact_template, dependent: :destroy

          accepts_nested_attributes_for :recipients
          accepts_nested_attributes_for :contact_template

          # delegate :tpl, to: :contact_template
        end

        #
        # Get recipient_id's for given email
        #
        def recipient_emails=(emails)
          unless emails.blank?
            emails = emails.reject { |c| c.blank? }
            unless emails.empty?
              self.recipients = emails.map { |m| Mokio::Recipient.new(email: m) }
            end
          end
        end

        #
        # Return recipient emails
        #
        def recipient_emails
          self.recipients.map(&:email).join(',')
        end
      end
    end
  end
end