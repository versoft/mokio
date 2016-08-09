class DeviseCustomFailure < Devise::FailureApp
  def redirect_url
    '/backend/users/sign_in'
  end
end
