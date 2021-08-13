module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ContactsController
      #
      module Contacts
        extend ActiveSupport::Concern

        included do

          before_action :init_obj, :set_author, :only =>[:create]
          before_action :set_editor, :only => [:create, :update]

        end

        #
        # Overriten create from CommonController#create (Mokio::Concerns::Controllers::Common)
        #
        def create
          respond_to do |format|
            if obj.save
              if !params[:save_and_new].blank?
                format.html { redirect_to obj_new_url(@obj_class.new), notice: Mokio::Concerns::Common::Translations::CommonTranslation.created(obj) }
                format.json { render action: 'new', status: :created, location: obj }
              else
                format.html { redirect_to obj_edit_url(obj), notice: Mokio::Concerns::Common::Translations::CommonTranslation.created(obj) }
                format.json { render action: 'index', status: :created, location: obj }
              end
            else
              format.html { render "new", notice: Mokio::Concerns::Common::Translations::CommonTranslation.not_created(obj) }
              format.json { render json: @obj.errors, status: :unprocessable_entity }
            end
          end
        end

        def init_obj
          create_obj( @obj_class.new(obj_params) )
        end

        def set_author
          obj.created_by = current_user.id
        end

        def set_editor
          obj.updated_by = current_user.id
          set_author if obj.created_by.blank? # for backward compatibility
        end

        #
        # Extended CommonController new (Mokio::Concerns::Controllers::Common)
        #
        def new

          super
          obj.build_contact_template
        end

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "content_management"
          @breadcrumbs_prefix_link = "contents"
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def contact_params #:doc:
            params.require(:contact).permit(
              extended_parameters,
              mokio_gems_parameters,
              :title,
              :subtitle,
              :intro,
              :content,
              :article_type,
              :contact,
              :active,
              :home_page,
              :slug,
              :lang_id,
              :recipient_emails => [],
              :menu_ids => [],
              :contact_template_attributes => Mokio::ContactTemplate.contact_template_attributes
            )
          end
      end
    end
  end
end