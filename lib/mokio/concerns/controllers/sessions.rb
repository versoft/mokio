module Mokio
  module Concerns
    module Controllers
      module Sessions
        extend ActiveSupport::Concern

        # POST /resource/sign_in
        def create
          valid_recaptcha = Mokio::Services::RecaptchaService.new(params[:recaptcha_token]).call
          if valid_recaptcha
            self.resource = warden.authenticate!(auth_options)
            set_flash_message!(:notice, :signed_in)
            sign_in(resource_name, resource)
            yield resource if block_given?
            respond_with resource, location: after_sign_in_path_for(resource)
          else
            build_resource(sign_in_params)
            # clean_up_passwords(resource)
            flash.now[:alert] = 'Test "Are you bot?" failed'
            # flash.delete :recaptcha_error
            render :new
          end
        end

        private

        # Build a devise resource passing in the session. Useful to move
        # temporary session data to the newly created user.
        def build_resource(hash = {})
          self.resource = resource_class.new(hash)
        end
      end
    end
  end
end