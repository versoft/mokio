module Mokio
  module Concerns
    module Models
      module History
        extend ActiveSupport::Concern
        included do
          belongs_to :historable, polymorphic: true
        end
      end
    end
  end
end
