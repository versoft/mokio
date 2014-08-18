module Mokio
  module Concerns
    module Models
      #
      # Concern for Recipient model
      #
      module Recipient
        extend ActiveSupport::Concern

        included do
          belongs_to :contact
          validates :email, :email => true
        end

        module ClassMethods
          #
          # Get ids from given emails
          #
          def ids_from_emails(emails)
            emails.delete(' ').split(',').map {|m| Mokio::Recipient.create(email: m).id }
          end
        end
      end
    end
  end
end