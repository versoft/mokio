module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ContentsController
      #
      module BaseContents
        extend ActiveSupport::Concern
        include Mokio::Concerns::Common::Translations
        included do
        end

        def new

          @contents = []
          Mokio::Lang.all.each {|lang| @contents << content_model.new(:lang_id => lang.id)}
          build_base_enabled
          @contents_select = build_contents

          # @contents.each {|content| @contents << content.build_contact_template}
        end

        def edit


          @contents = []
          obj.contents.each {|content| @contents << content}
          create_form_obj(obj,@contents)
          @contents.each {|content| content.build_gmap if content.class.has_gmap_enabled? && content.gmap.nil?}
          @contents_select = build_contents
          build_base_enabled

        end

        def create

          create_obj( @obj_class.new(create_base_params))
          params[obj_name][:contents_attributes].each do |key,value|
            if value[:form_active] == '1'
              obj.contents << content_model.new(value)
            end
          end

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
              @contents = []
              obj.contents.each {|content| @contents << content}
              create_form_obj(obj,@contents)

              format.html { render "new", notice: CommonTranslation.not_created(obj) }
              format.json { render json: @obj.errors, status: :unprocessable_entity }
            end
          end
        end

        def update

          contents_params = obj_params
          contents_params[:contents_attributes] = {}

          params[obj_name][:contents_attributes].each do |key,value|
            if value[:form_active] == '1'
              contents_params[:contents_attributes][key.to_i] = value
            end
          end

          respond_to do |format|

            if obj.update(contents_params)
              if !params[:save_and_new].blank?
                format.html { redirect_to obj_new_url(@obj_class.new), notice: CommonTranslation.updated(obj) }
                format.json { head :no_content }
              else
                format.html { redirect_to obj_index_url, notice: CommonTranslation.updated(obj) }
                format.json { render action: 'index', status: :created, location: obj }
              end
            else
              @contents = []
              obj.contents.each {|content| @contents << content}
              create_form_obj(obj,@contents)

              format.html { render "edit", notice: CommonTranslation.not_updated(obj) }
              format.json { render json: @obj.errors, status: :unprocessable_entity }

            end
          end
        end


        def base_attributes
          [:id,:title,:main_pic,:display_from,:display_to,:home_page,:active]
        end

        def content_attributes
          [extended_parameters,:id,:title, :subtitle, :intro, :content, :article_type, :home_page, :tpl, :contact, :active, :seq, :lang_id,:gallery_type, :display_from, :display_to, :main_pic, :tag_list,:menu_ids => [], :data_files_attributes => [:data_file, :main_pic, :id, :remove_data_file]]
        end

        # update content form
        def update_content_form
          @contents = []
          @contents <<  Mokio::Content.find_by_base_content_id(params[:base_content_id])

          if params[:base_id].present?
            obj = Mokio::BaseContent.find(params[:base_id])
            obj.contents.each {|content| @contents << content}
          end

          Mokio::Lang.all.each {|lang| @contents << content_model.new(:lang_id => lang.id) if @contents.collect{|content| content.lang_id }.exclude?(lang.id)}

          @contents.each {|content| content.build_gmap if content.class.has_gmap_enabled? && content.gmap.nil?}
          @contents_select = build_contents
          @content = render_to_string "mokio/backend/common/multi_lang_form_content" , :layout => false
          @lang = params[:lang_id]
        end


        private
        #
        # Never trust parameters from the scary internet, only allow the white list through.
        #

        def base_content_params #:doc:
          params.require(:base_content).permit(base_attributes)
        end

        def create_base_params
          base_object_params = obj_params
          base_object_params.delete(:contents_attributes)
          base_object_params.delete(:meta_attributes)
          base_object_params
        end

        # create Mokio::Contents model for self class /article,contact,galleries
        def content_model
          name= "Mokio::#{self.controller_name.gsub('base_','').singularize.classify}".constantize
          name
        end

        # build meta and gmap for many contents
        def build_base_enabled
          @contents.each {|content| content.build_gmap  if content.class.has_gmap_enabled? && content.gmap.nil?}
          @contents.each { |content| content.build_meta if content.class.has_meta_enabled? && content.meta.nil?}
        end
        # build contents collection for select

        def build_contents
          Mokio::Content.all.where("base_content_id is NULL")
        end

        def create_form_obj(obj,arr)

          Mokio::Lang.all.each {|lang| arr << content_model.new(:lang_id => lang.id) if obj.contents.collect{|content| content.lang_id }.exclude?(lang.id)}
          arr
        end

      end
    end
  end
end