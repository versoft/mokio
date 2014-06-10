module Mokio
  class Backend::UsersController < Backend::CommonController

    def new
      @user = User.new
    end

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

    def edit_password
      @password_only = true
      @user = current_user
      obj = @user
    end

    def update_password
      # @current = current_user 
      @user = current_user
      obj = @user
      respond_to do |format|
        if @user.update(user_params)
          sign_in(@user, :bypass => true) #I18n.t("prices.quotation_not_created", title: l(@date))
          format.html { redirect_to backend_users_path, notice: I18n.t("users.password_updated") }
          format.json { render action: 'index', status: :updated}
        else
          format.html { render "edit", notice: I18n.t("users.password_not_updated") }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params[:user].permit(:first_name, :last_name, :email, :password, :password_confirmation, :market_id, :roles => [])
      end

  end
end