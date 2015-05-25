module Mokio
  module Concerns
    module Models
      #
      # Concern for ContactTemplate model
      #
      module ContactTemplate
        extend ActiveSupport::Concern

        included do

          belongs_to :base_contact
          accepts_nested_attributes_for :base_contact

          belongs_to :contact
          accepts_nested_attributes_for :contact
        end

        module ClassMethods
          #
          # Table of contact_template_attributes
          #
          def contact_template_attributes
            [ :tpl ]
          end
        end
      end
    end
  end
end