module Mokio
  module FrontendEditor
    class EditorField
      include CanCan::Ability
      # include ActionView::Helpers::TagHelper
      # include ActionView::Context
      # include ActionView::Helpers::OutputSafetyHelper

      def initialize(current_user, block_params, html_block, locale)
        @current_user = current_user
        @block_params = block_params
        @section_id = block_params[:id]
        @blocks = block_params[:blocks]
        @path = block_params[:path]
        @section_text = html_block
        @locale = locale
      end

      def process_block
        block = find_block
        if block
          text = block.content
        else
          text = @section_text.gsub("\n", ' ').squeeze(' ').strip
        end
        if can_edit?
          prepare_editor_html(text)
        else
          text.html_safe
        end
      end

      private

      def find_block
        block = nil
        if @blocks
          filtered_blocks = @blocks.select{ |eb| (eb.hash_id == @section_id && eb.lang == @locale) }
          block = filtered_blocks.first
          unless block
            block = find_block_by_id
            # update location
            block.update_location(@path)
          end
        else
          block = find_block_by_id
        end
        block
      end

      def find_block_by_id
        Mokio::EditableBlock.find_by(
          hash_id: @section_id, 'lang': @locale
        )
      end

      def prepare_editor_html(text)
        obj = Nokogiri::HTML.fragment(text)
        root = obj.children.first
        root.set_attribute('data-editableblock', @section_id)
        root.set_attribute('contenteditable', 'true')
        css_class = root.attribute('class')
        root.set_attribute('class', "#{css_class} mokio-editor-editableblock")
        obj.to_html.html_safe
      end

      def can_edit?
        return false unless @current_user

        @current_user.can? :manage, Mokio::Content
      end

    end
  end
end
