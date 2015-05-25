module Mokio
  module Concerns
    module Models #:nodoc:
      #
      # Concern for Mokio::Article model
      #
      module BaseArticle
        extend ActiveSupport::Concern

        included do
          attr_accessor :form_active

          def form_active
            false
          end

        end
      end
    end
  end
end