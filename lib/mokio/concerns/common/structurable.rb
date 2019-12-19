module Mokio
  module Concerns
    module Common
      module Structurable
        extend ActiveSupport::Concern

        included do
          has_one :structure, as: :structurable, :class_name => "Mokio::Structure",dependent: :destroy
          before_save :build_structurable_objects
          after_destroy :update_structurable_objects
        end

        def childrens
          return nil if self.structure.nil?
          self.structure.children.includes(:structurable).map(&:structurable)
        end

        def parent
          return nil if self.structure.parent.nil?
          return self.structure.parent.structurable
        end

        private

        # build relation structure
        def build_structurable_objects
          if self.structure.nil?
            self.build_structure
          end
        end

        # remove childrens - parent_id
        def update_structurable_objects
          self.structure.children.update_all(parent_id: nil)
        end

      end
    end
  end
end
