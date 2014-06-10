module Mokio
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :configure_permitted_parameters, if: :devise_controller?

    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, roles: [])}
      end

    private 

      def after_sign_out_path_for(resource_or_scope)
        backend_root_path
      end

      def after_sign_in_path_for(resource)
        backend_root_path
      end

      rescue_from CanCan::AccessDenied do |exception|
         render :template =>'/mokio/backend/errors/unauthorized', :alert => exception.message # backend_root_url
      end
  end
end