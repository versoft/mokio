class PasswordsController < Devise::PasswordsController
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    flash[:alert]=t("devise.passwords.send_instructions")
    Mokio::Engine.routes.url_helpers.root_path<<new_user_session_path[1..-1] #delete one slash to prevent link like this: /backend//users/sign_in
  end

end