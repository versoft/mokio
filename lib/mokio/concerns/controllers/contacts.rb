module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ContactsController
      #
      module Contacts
        extend ActiveSupport::Concern

        included do
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
            params.require(:contact).permit(extended_parameters, :title, :subtitle, :intro, :content, :article_type, :contact, :active,:home_page, :lang_id, :recipient_emails, :menu_ids => [], :contact_template_attributes => Mokio::ContactTemplate.contact_template_attributes)
          end
      end
    end
  end
end