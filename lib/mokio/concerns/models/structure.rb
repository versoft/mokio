module Mokio
  module Concerns
    module Models
      module Structure
        extend ActiveSupport::Concern

        included do
          belongs_to :structurable, polymorphic: true
          has_many :children, :foreign_key => "parent_id" , :class_name => "Mokio::Structure"
          belongs_to :parent, :class_name => "Mokio::Structure",foreign_key: 'parent_id', :optional => true
        end

        module StructurableModel
          extend ActiveSupport::Concern

          included do
            has_one :structure, as: :structurable
          end

          def childrens
            self.structure.children
          end

          def parent
            self.structure.parent.structurable
          end
        end
      end
    end
  end
end