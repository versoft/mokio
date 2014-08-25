module Mokio
  module Concerns
    module Models
      #
      # Concern for Lang model
      #
      module Lang
        extend ActiveSupport::Concern

        # included do
        #   scope :default, -> {where(shortname: Mokio.frontend_default_lang).first}
        # end
          included do
            has_many :menu ,:dependent => :destroy
          end

        module ClassMethods

          def default
            Mokio::Lang.where(shortname: Mokio.frontend_default_lang).first
          end
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["name","shortname","active"]
          end

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


