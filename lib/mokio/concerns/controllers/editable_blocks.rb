module Mokio
  module Concerns
    module Controllers
      module EditableBlocks

        extend ActiveSupport::Concern
        included do
          before_action :set_obj, only: [:update]
        end

        def create
          raise 'unauthorize' unless current_user.can? :manage, Mokio::Content

          editable_block = Mokio::EditableBlock.find_or_initialize_by(
            hash_id: editable_block_params[:hash_id],
            lang: editable_block_params[:lang]
          )
          if editable_block.persisted?
            editable_block.editor = current_user
          else
            editable_block.author = current_user
          end
          editable_block.content = editable_block_params[:content].strip
          new_location = editable_block_params[:location]

          unless new_location.blank?
            location = editable_block.location
            location ||= ''
            unless location.include?(new_location)
              editable_block.location = "#{location} #{new_location}".strip
            end
          end

          respond_to do |format|
            if editable_block.save!
              format.html {}
              format.json { render json: { msg: 'ok' } }
            else
              format.html {}
              format.json { render json: editable_block.errors, status: :unprocessable_entity }
            end
          end
        end

        def destroy
          editable_block = Mokio::EditableBlock.find_by!(
            hash_id: editable_block_params[:hash_id],
            lang: editable_block_params[:lang]
          )
          editable_block.destroy!
          respond_to do |format|
            format.json { render json: { msg: 'ok' } }
          end
        end

        private

        def editable_block_params
          params[:editable_block].permit(:hash_id, :content, :location, :lang)
        end

      end
    end
  end
end
