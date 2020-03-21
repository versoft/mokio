class Mokio::PasswordsController < Devise::PasswordsController
  prepend_before_action :require_no_authentication, except: [:send_pass_change_link]

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    flash[:password_change_info] = t('devise.passwords.send_paranoid_instructions')
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  def send_pass_change_link
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: users_path)
    else
      respond_with({}, location: edit_user_path(resource))
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
