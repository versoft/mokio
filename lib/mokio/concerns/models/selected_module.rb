module Mokio
  module Concerns
    module Models
      #
      # Concern for SelectedModule model
      #
      module SelectedModule
        extend ActiveSupport::Concern

        included do
          default_scope { order('seq') }
          belongs_to :menu
          belongs_to :available_module
          acts_as_list :column => :seq, :scope => :menu_id
        end
      end
    end
  end
end