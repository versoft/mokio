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
      end
    end
  end
end