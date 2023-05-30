module Mokio
  module FrontendEditor
    class EditPanel
      include CanCan::Ability

      def initialize(controller_resource, current_user)
        @resource = nil
        @resource_edit_url = nil
        @resource_exists = false
        @controller_resource = controller_resource
        @current_user = current_user
        choose_resource
      end

      def check_resource_exists?
        return false unless @current_user.present?

        @resource_exists
      end

      def get_edit_url
        make_url
        @resource_edit_url
      end

      def self.render_edit_panel(edit_panel_instance)
        return '' unless (edit_panel_instance && edit_panel_instance.check_resource_exists?)

        url = edit_panel_instance.get_edit_url
        template = ApplicationController.render(
          template: 'mokio/editor_panel/edit_panel',
          locals: { url: url }
        )
        template.html_safe

      end

      private

      def make_url
        if @resource.present?
          @resource_edit_url = Mokio::Engine.routes.url_helpers.url_for([:edit, @resource, only_path: true])
        end
      end

      def choose_resource
        if av_controller_resource.include?(@controller_resource.class.to_s)
          @resource = @controller_resource
        end
        @resource_exists = @resource.present?
      end

      def av_controller_resource
        if !Mokio.frontend_edit_panel_models ||
          Mokio.frontend_edit_panel_models.blank?
          raise "not valid setting Mokio.frontend_edit_panel_models"
        end
        Mokio.frontend_edit_panel_models
      end

    end
  end
end
