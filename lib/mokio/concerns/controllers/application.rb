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
            devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
          end

          #
          # Standard devise after_sign_out_path_for
          #
          def after_sign_out_path_for(resource_or_scope) #:doc:
            get_path_from_config(resource, Mokio.after_sign_out_path[resource_name], mokio.user_session_path)
          end

          #
          # Standard devise after_sign_in_path_for
          #
          def after_sign_in_path_for(resource) #:doc:
            get_path_from_config(resource,  Mokio.after_sign_in_path[resource_name], mokio.root_path)
          end

        private

        def get_path_from_config(resource, config, default_path)
          url = config.has_key?(:roles) ?
            path_for_roles(config, resource)
          :
            get_path_from_hash(config, resource)

          url ||=default_path
          url
        end

        def path_for_roles(hash, resource)
          url = nil
          hash[:roles].each do |role_name, value|
            if resource.roles.include? role_name
              url = get_path_from_hash value, resource
              break
            end
          end
          url
        end

        def get_path_from_hash(hash, resource)
          url = hash[:path].to_s if hash.has_key? :path
          url = self.send(hash[:method]) if hash.has_key? :method
          url
        end

      end
    end
  end
end
