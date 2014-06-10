module Mokio
  class Backend::ContactsController < Backend::CommonController

    def new
      super
      obj.build_contact_template
    end

    private
      #
      # Never trust parameters from the scary internet, only allow the white list through.
      #
      def contact_params
        params.require(:contact).permit(extended_parameters, :title, :intro, :content, :article_type, :contact, :active, :lang_id, :recipient_emails, :contact_template_attributes => ContactTemplate.contact_template_attributes)
      end
  end
end
