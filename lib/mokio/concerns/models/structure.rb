module Mokio
  module Concerns
    module Models
      module Structure
        extend ActiveSupport::Concern

        included do
          belongs_to :structurable, polymorphic: true, :class_name => "Mokio::Structure"
          has_many :children, :foreign_key => "parent_id" , :class_name => "Mokio::Structure" do
            def << (object)
              unless object.structure.nil?
                structure = proxy_association.owner
                structure.children.concat(object.structure)
              end
            end
          end
          belongs_to :parent, :class_name => "Mokio::Structure",foreign_key: 'parent_id', :optional => true
        end

      end
    end
  end
end

