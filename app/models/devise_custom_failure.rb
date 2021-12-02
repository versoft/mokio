class DeviseCustomFailure < Devise::FailureApp
  def redirect_url
    '/backend/users/sign_in'
  end

  def respond
    if http_auth?
      http_auth
    else
      flash[:alert] = I18n.t(:invalid, :scope => [ :devise, :failure ])
      redirect
    end
  end
end