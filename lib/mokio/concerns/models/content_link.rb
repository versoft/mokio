module Mokio
  module Concerns
    module Models
      #
      # Concern for ContentLink model
      #
      module ContentLink
        extend ActiveSupport::Concern

        included do
          default_scope { order('seq') }
          belongs_to :menu, :touch => true
          belongs_to :content, :touch => :etag
          acts_as_list :column => :seq, :scope => :menu_id
        end
      end
    end
  end
end