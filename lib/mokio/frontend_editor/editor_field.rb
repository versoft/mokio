module Mokio
  module FrontendEditor
    class EditorField
      include CanCan::Ability

      def initialize(current_user, block_params, html_block, locale)
        @current_user = current_user
        @block_params = block_params
        @editor_mode = (@block_params[:editor] || :standard).to_s
        @editor_popup = !!@block_params[:popup] || false
        
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
        # first_element = obj.children.first
        # editor_mode = "p"
        # if ['a', 'span', 'button'].include?(first_element.name)
        #   editor_mode = "br"
        # end

        if @editor_popup == true
          html = <<-HT
          <div class="mokio-editor-popup" data-editableblock-popup='#{@section_id}' style="display:none;">
              <button class="mokio-editor-popup-close-btn">&times;</button>

              <div
              class='mokio-editor-editableblock'
              data-editableblock='#{@section_id}'
              data-editor-mode='#{@editor_mode}'
              data-editor-popup='#{@editor_popup}'

              >
              #{obj.to_html}
              </div>
          </div>

          <div data-editableblock-section='#{@section_id}'>
          #{obj.to_html}
          </div>
          HT
        else
          html = <<-HT
            <div
            class='mokio-editor-editableblock'
            data-editableblock='#{@section_id}'
            data-editor-mode='#{@editor_mode}'
            data-editor-popup='#{@editor_popup}'

            >
            #{obj.to_html}
            </div>
          HT
        end
        
        html.html_safe

      end 

      def can_edit?
        return false unless @current_user

        @current_user.can? :manage, Mokio::Content
      end
    end
  end
end
