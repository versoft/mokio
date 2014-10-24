module Mokio
  module Concerns
    module Models

      module ExternalScript
        extend ActiveSupport::Concern

        included do

          include Mokio::Concerns::Models::Common

          validates :name, presence: true
          validates :script, presence: true
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["name", "script"]
          end
        end

        def name_view
          (ActionController::Base.helpers.link_to self[:name], ApplicationController.helpers.edit_url(self.class.base_class, self)).html_safe
        end

        def code_view
          self.script.truncate(200)
        end

        def editable  #:nodoc:
          true
        end

        def deletable  #:nodoc:
          true
        end


      end
    end
  end
end