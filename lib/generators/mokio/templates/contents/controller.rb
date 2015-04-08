<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
module Mokio
  class <%= controller_class_name %>Controller < Mokio::CommonController

  private
    #
    # Never trust parameters from the scary internet, only allow the white list through.
    #
    def <%=file_name %>_params #:doc:
      params.require(:<%=file_name %>).permit( extended_parameters, :title, :subtitle, :intro, :content, :article_type, :home_page, :tpl, :contact, :active, :seq, :lang_id,
        :gallery_type, :display_from, :display_to, :main_pic, :tag_list, :menu_ids => [], :data_files_attributes => [:data_file, :main_pic, :id, :remove_data_file]
      )
    end



end
end
<% end -%>
