Rails.configuration.to_prepare do
  Devise::SessionsController.class_eval do
    before_action :invalidate_current_user_session, only: [:destroy]

    private
      def invalidate_current_user_session
        current_user.invalidate_all_sessions! if current_user.present?
      end  
  end
end
