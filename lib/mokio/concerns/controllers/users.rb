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
          load_and_authorize_resource
        end

        #
        # Overwritten new from CommonController#new (Mokio::Concerns::Controllers::Common)
        #
        def new
          @user = Mokio::User.new
        end

        #
        # Overwritten new from CommonController#create (Mokio::Concerns::Controllers::Common)
        #
        def create
          create_obj( @obj_class.new(obj_params) )
          obj.current_user = current_user
          respond_to do |format|
            if obj.save
              if !params[:save_and_new].blank?
                format.html { redirect_to obj_new_url(@obj_class.new), notice: CommonTranslation.created(obj) }
                format.json { render action: 'new', status: :created, location: obj }
              else
                format.html { redirect_to obj_index_url, notice: CommonTranslation.created(obj) }
                format.json { render action: 'index', status: :created, location: obj }
              end
            else
              format.html { render "new", notice: CommonTranslation.not_created(obj) }
              format.json { render json: @obj.errors, status: :unprocessable_entity }
            end
          end
        end

        #
        # Overwritten new from CommonController#update (Mokio::Concerns::Controllers::Common)
        #
        def update
          @current = current_user
          obj.current_user = current_user
          respond_to do |format|
            if obj.update(obj_params)
              #only when password os changed for current user, sign in (with updated password) is required
              if obj.id == @current.id
                sign_in(obj, :bypass => true)
              end
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
          set_obj
          # Request Referer for redirect user in the place where it was before the change password
          session[:return_to] = request.referer
          @password_only = true
        end

        #
        # Updating password for user
        #
        def update_password
          set_obj
          @user.only_password = true
          respond_to do |format|
            if @user.update(user_params)
              sign_in(@user, :bypass => true)

              format.html { redirect_to session[:return_to] ,notice: I18n.t("users.password_updated") }
              # format.json { render action: 'edit_password', status: :updated}
            else
              @password_only = true
              format.html { render "edit_password", notice: I18n.t("users.password_not_updated") }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        end

        def destroy
          respond_to do |format|
            if can_remove_user?
              if obj.destroy
                redirect_back(format, obj_index_url, CommonTranslation.deleted(obj))
              else
                redirect_back(format, obj_index_url, CommonTranslation.not_deleted(obj))
              end
            else
              redirect_back(format, obj_edit_url(obj), CommonTranslation.password_not_match(obj))
            end
          end
        end

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "settings"
          @breadcrumbs_prefix_link = ""
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def user_params #:doc:
            params[:user].permit(:first_name, :last_name, :email, :password, :password_confirmation, :market_id, :roles => [])
          end

          def remove_params
            params[:user].permit(:confirm_delete)
          end

          def can_remove_user?
            # if password is correct and user is NOT super admin - allow remove
            current_user.valid_password?(remove_params[:confirm_delete]) &&
            !obj.is_super_admin?
          end
      end
    end
  end
end