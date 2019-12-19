module Mokio
  module Concerns
    module Models
      module StructurableModel
        extend ActiveSupport::Concern

        included do
          has_one :structure, as: :structurable, :class_name => "Mokio::Structure"
        end

        def childrens
          # raise structure.inspect
          self.structure.children
        end

        def parent
          self.structure.parent.structurable
        end

      end
    end
  end
end
