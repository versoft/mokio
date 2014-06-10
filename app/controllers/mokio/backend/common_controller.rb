module Mokio  
  #
  # Creating simple actions for controllers, use in others with < Backend::CommonController
  # 
  # To override some actions just simply define them in your controller
  #
  # If you need to add something more but still use CommonController remeber to call 'super' in your controller action
  # ex:
  # class Backend::SamplesController < Backend::CommonController
  #   def index
  #     super
  #     my_additional_action
  #   end
  # end
  #
  # Remember that CommonController uses variable named as your controller
  # For samples_controller variable is @sample
  # => See obj method in Common::Controller::Object lib
  #
  class Backend::CommonController < Backend::BaseController
    include Mokio::Common::Controller
    
    load_and_authorize_resource :user
    
    def index
      respond_to do |format|
        # @TODO zrobic cos by przy formacie html nie renderował się javascript z datatable
        format.html # { create_obj(@obj_class.page( params[:page] ) ) } 
        format.json { render json: ::CommonsDatatable.new(view_context, @obj_class) }
      end
    end

    def new
      create_obj(@obj_class.new)
      build_enabled(obj)
    end

    def edit
      obj.build_gmap if obj.class.has_gmap_enabled? && obj.gmap.nil? # build gmap if it hasn't created before. Relation with gmap isn't nessesary !
    end

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

    def destroy
      respond_to do |format|
        if obj.destroy
          redirect_back(format, obj_index_url, CommonTranslation.deleted(obj))
        else
          redirect_back(format, obj_index_url, CommonTranslation.deleted(obj))
        end
      end
    end

    #
    # Method amoeba_dup duplicates object with every associations specified in Model
    # ex:
    #   class Post < ActiveRecord::Base
    #   has_many :comments
    #   has_many :tags
    #   has_many :authors
    #
    #   amoeba do
    #     include_field [:tags, :authors]
    #   end
    # ------------------------------------------------------------------------
    # if you use this method add to your controller resources in routes.rb: 
    #    member do
    #      get :copy
    #    end
    def copy
      create_obj(obj.amoeba_dup)
      build_enabled(obj)
    end

    #
    # Method for ajax updating "active" attribute
    # ------------------------------------------------------------------------
    # if you use this method add to your controller resources in routes.rb: 
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
  end
end