<% module_namespacing do -%>
module Mokio
  class <%= class_name %> < Mokio::Content

    def columns_for_table
      %w(title active type updated_at lang_id)
    end

    def editable
      true
    end

    def deletable
      true
    end

    # Generate url to edit content
    def title_view
      (ActionController::Base.helpers.link_to self[:name], ApplicationController.helpers.edit_url(self.class.base_class, self)).html_safe
    end

  end
end
<% end -%>