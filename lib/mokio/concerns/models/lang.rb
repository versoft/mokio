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
        end
      end
    end
  end
end