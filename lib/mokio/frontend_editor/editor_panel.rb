module Mokio
  module FrontendEditor
    class EditorPanel
      include CanCan::Ability

      def self.location(path)
        data = Rails.application.routes.recognize_path(path)
        "#{data[:controller]}##{data[:action]}"
      end

      def initialize(current_user, path)
        @current_user = current_user
        @path = path
      end

      def render_editor_panel
        return nil unless can_edit?

        template = ApplicationController.render(
          template: 'mokio/editor_panel/panel',
          locals: { user: @current_user, path: @path }
        )
        template.html_safe
      end

      private

      def can_edit?
        return false unless @current_user

        @current_user.can? :manage, Mokio::Content
      end

    end
  end
end
