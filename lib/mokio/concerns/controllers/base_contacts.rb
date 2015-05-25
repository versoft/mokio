module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ContactsController
      #
      module BaseContacts
        extend ActiveSupport::Concern

        included do
        end

        #
        # Extended CommonController new (Mokio::Concerns::Controllers::Common)
        #

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "content_management"
          @breadcrumbs_prefix_link = "contents"
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def base_contact_params #:doc:
            params.require(:base_contact).permit(base_attributes,:contents_attributes => content_attributes, :contact_template_attributes => Mokio::ContactTemplate.contact_template_attributes)
          end
      end
    end
  end
end