module Mokio
  module Concerns 
    module Controllers 
      #
      # Concern for ApplicationController
      #
      module Application
        extend ActiveSupport::Concern

        included do
          # Prevent CSRF attacks by raising an exception.
          # For APIs, you may want to use :null_session instead.
          protect_from_forgery with: :exception

          before_filter :configure_permitted_parameters, if: :devise_controller?

          rescue_from CanCan::AccessDenied do |exception|
            render :template =>'/mokio/errors/unauthorized', :alert => exception.message # backend_root_url
          end
        end

        protected
          #
          # <b>before_filter</b> in ApplicationController using <b>gem devise</b>
          #
          def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, roles: [])}
          end

        private 
          #
          # Standard devise after_sign_out_path_for
          #
          def after_sign_out_path_for(resource_or_scope) #:doc:
            mokio.user_session_path
          end

          #
          # Standard devise after_sign_in_path_for
          #
          def after_sign_in_path_for(resource) #:doc:
            mokio.root_path
          end
      end
    end
  end
end