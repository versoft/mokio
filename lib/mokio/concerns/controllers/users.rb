module Mokio
  module Concerns
    module Controllers
      #
      # Concern for UsersController
      #
      module Users
        extend ActiveSupport::Concern

        include Mokio::Concerns::Common::Translations
        
        included do
        end

        #
        # Overriten new from CommonController#new (Mokio::Concerns::Controllers::Common)
        #
        def new
          @user = Mokio::User.new
        end

        #
        # Overriten new from CommonController#update (Mokio::Concerns::Controllers::Common)
        #
        def update
          @current = current_user 
          respond_to do |format|
            if obj.update(obj_params)
              sign_in(@current, :bypass => true)
              if !params[:save_and_new].blank?
                format.html { redirect_to obj_new_url(@obj_class.new), notice: CommonTranslation.updated(obj) }
                format.json { head :no_content }
              else 
                format.html { redirect_to obj_index_url, notice: CommonTranslation.updated(obj) }
                format.json { render action: 'index', status: :created, location: obj }
              end
            else
              format.html { render "edit", notice: CommonTranslation.not_updated(obj) }
              format.json { render json: @obj.errors, status: :unprocessable_entity }
            end
          end
        end

        #
        # Editing password for user
        #
        def edit_password

          # Request Referer for redirect user in the place where it was before the change password
          session[:return_to] = request.referer
          @password_only = true
          @user = current_user
          obj = @user
        end

        #
        # Updating password for user
        #
        def update_password
          # @current = current_user
          @user = current_user
          obj = @user
          respond_to do |format|
            if @user.update(user_params)
              sign_in(@user, :bypass => true) #I18n.t("prices.quotation_not_created", title: l(@date))

              format.html { redirect_to session[:return_to] ,notice: I18n.t("users.password_updated") }
              # format.json { render action: 'edit_password', status: :updated}
            else
              @password_only = true
              format.html { render "edit_password", notice: I18n.t("users.password_not_updated") }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def user_params #:doc:
            params[:user].permit(:first_name, :last_name, :email, :password, :password_confirmation, :market_id, :roles => [])
          end
      end
    end
  end
end