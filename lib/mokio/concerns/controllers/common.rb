module Mokio
  module Concerns
    module Controllers
      # 
      # Concern for CommonController. Many important controller logic is placed here.
      #
      # Most of Mokio's controllers are inherited by this controller. The main logic is to not repeat same part of code with changing only variables.
      # Model and instance variable name is parsed from controller name (see Mokio::Concerns::Common::ControllerObject).
      # Its also using translations specified by us to match action name (model.deleted, model.created, model.not_updated etc.).
      # Devise's load_and_authorize_resource is also placed here
      #
      # == CommonController provides:
      #
      # * +index+ method with json sending data.
      # Its using common/index view and place date into jquery.datatable plugin (you can see in backend/datatable.js.coffee.erb file). 
      # We send json as CommonsDatatable object (app/datatables/commons_datatable.rb)
      # Columns displayed in table are specified in used model inside method called columns_for_table.
      # 
      # * +new+ method with building meta/gmap if they are enabled in used model
      # Its using common/new view and need partial '_form' with specifed form elements. Main form uses simple_form.
      #
      # * +edit+ method with building gmap if its enabled in used model
      # Its using common/edit and need same partial as in 'new' action.
      #
      # * +create+ method
      # Simple creating and saving object to database if passed validation. 
      #
      # * +update+ method
      # Simple updating object in database
      #
      # * +destroy+ method
      # Standard destroying object from database. Redirects back (see in Mokio::Concerns::Controllers::Base)
      #
      # * +copy+ method
      # Works similarly to 'new' but fill new object data by copying record using 'amoeba' gem
      #
      # * +update_active+ method (ajax)
      # Ajax updating active field
      #
      module Common
        extend ActiveSupport::Concern

        #
        # translations have to be included here
        #
        include Mokio::Concerns::Common::Translations

        included do
          include Mokio::Concerns::Common::ControllerObject
          include Mokio::Concerns::Common::ControllerFunctions

          load_and_authorize_resource
        end



        #
        # Index action renders <b>json</b> with parameters to jquery.datatables
        #
        def index
          respond_to do |format|
            # @TODO zrobic cos by przy formacie html nie renderował się javascript z datatable
            format.html # { create_obj(@obj_class.page( params[:page] ) ) } 
            format.json { render json: ::CommonsDatatable.new(view_context, @obj_class) }
          end
        end

        #
        # Standard new action. Create object for specified class
        #
        def new
          create_obj(@obj_class.new)
          build_enabled(obj)
        end

        #
        # Standard edit action.
        #
        def edit
          obj.build_gmap if obj.class.has_gmap_enabled? && obj.gmap.nil? # build gmap if it hasn't created before. Relation with gmap isn't nessesary !
        end

        #
        # Standard create action. Create and save object for specified class in database
        #
        def create
          create_obj( @obj_class.new(obj_params) )

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
        # Standard update action. Update params object for specified class in database
        #
        def update
          respond_to do |format|
            if obj.update(obj_params)
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
        # Standard destroy action. Remove object for specified class from database
        #
        def destroy
          respond_to do |format|
            if obj.destroy
              redirect_back(format, obj_index_url, CommonTranslation.deleted(obj))
            else
              redirect_back(format, obj_index_url, CommonTranslation.not_deleted(obj))
            end
          end
        end

        # 
        # Similar to <b>new</b> action but creates new object with copied data.
        # This method is using amoeba_dup to duplicate object with every associations specified in Model (<b>gem amoeba</b>)
        # === Examples
        #   class Post < ActiveRecord::Base
        #     has_many :comments
        #     has_many :tags
        #     has_many :authors
        #
        #   amoeba do
        #     include_field [:tags, :authors]
        #   end
        #
        # If you use this method add to your controller resources in routes.rb: 
        #    member do
        #      get :copy
        #    end
        # ----------------------------------------------------------------------
        def copy
          create_obj(obj.amoeba_dup)
          build_enabled(obj)
        end

        #
        # Method for ajax updating "active" attribute
        # If you use this method, add to your controller resources in routes.rb: 
        #    member do
        #      get :update_active
        #    end
        def update_active
          if obj.update_attribute(:active, !obj.active)
            if obj.active
              flash[:notice] = CommonTranslation.update_active_true(obj)
            else
              flash[:error] = CommonTranslation.update_active_false(obj)
            end
          else
            logger.error "[#{@obj_class}] id:#{obj.id} name/title:#{obj_title} cannot update_attribute active"
          end

          respond_to do |format|
            format.html { render :nothing => true }
            format.js   { render :nothing => true }
          end
        end

        #
        # Renders additional buttons in index view
        #
        def render_additional_index_buttons
          template = self.additional_index_buttons
          if !template.nil?
              result = render_to_string :partial => template
            result.html_safe
          else
            ""
          end
        end

        #
        # Renders additional action buttons in datatable row in index view
        # ==== Attributes
        # * +obj+ - record object from database
        #
        def render_additional_action_buttons(obj)
          template = self.additional_action_buttons
          if !template.nil?
            result = render_to_string  :partial => template, :locals => {obj: obj}
            result.html_safe
          else
            ""
          end
        end

        # Returns string with path to partial <b>html</b>
        # Override when you want to add other buttons
        # to header in index view
        #
        # ==== Examples
        #   "mokio/my_objects/some_btn"
        # refers to file:
        #   "mokio/my_objects/_some_btn.html.*(slim/erb/haml)"
        #
        def additional_index_buttons
          nil
        end

        # Returns string with path to partial <b>json</b>
        # Override when you want to add other action buttons
        # to datatable row in index view
        #
        # ==== Examples
        #   "mokio/my_objects/some_row_action"
        # refers to file:
        #   "mokio/my_objects/_some_row_action.json.*(slim/erb/haml)"
        #
        def additional_action_buttons
          nil
        end

      end
    end
  end
end