module Mokio
  module Concerns
    module Models
      #
      # Concern for Photo model
      #
      module Photo
        extend ActiveSupport::Concern

        included do
          before_create :add_seq
        end

        module ClassMethods
        end

        #
        # Update seq field <b>before_create</b>
        #
        def add_seq
          photo = Mokio::Photo.where(imageable_id: self.imageable_id)
          if !photo.blank?
            lastseq = photo.order_default.last.seq
            self.seq = lastseq.to_i + 1
          else
            self.seq = 1
          end 
        end
        
        def thumb_name
          :thumb
        end
      end
    end
  end
end