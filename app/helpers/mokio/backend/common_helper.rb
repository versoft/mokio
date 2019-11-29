module Mokio
  module Backend
    module CommonHelper

      def has_data_files?(obj)
        obj.respond_to?("data_files") && obj.respond_to?("default_data_file")
      end

      #
      # returns which table stores data files for object
      # default: data_files
      #
      def data_file_model(obj)
        obj.respond_to?("data_file_type") ? obj.data_file_type.to_s.demodulize.tableize : "data_files"
      end

      def responsive_dynamic_table(without_search = false,&block)
        without_search_class = (without_search) ? 'without-search': ''
        content_tag :table, :data => {:source => datatable_source_url}, :class => "responsive dynamicTable display table table-bordered #{without_search_class}", :border => 0, :cellpadding => 0, :cellspacing => 0, :width => "100%", :id =>"dTable" do
          capture(&block)
        end
      end


      def datatable_source_url
        # with empty return  should work properly
        rescue
          contents_url( format: "json")
      end

      def common_form(&block)
        content_tag :div, :class => "form-row row-fluid" do
          content_tag :div, :class => "span12" do
            capture(&block)
          end
        end
      end

      def box_title(name = nil, h4class = "", &block)
        content_tag :div, :class => "title" do
          content_tag :h4, class: h4class do
            if name
              tag :span
              concat(name)
            end
            capture(&block) unless name
          end
        end
      end

      # ======================================================= Buttons
      #
      # controls buttons
      #
      def table_controls_edit_btn(link, from_commons_datatable = false)
        content_tag :a, :class => "tip edit", :href => link, "data-hasqtip" => true, "aria-describedby" => "qtip-2", :title => bt("edit") do
          tag :span, :class => "icon12 icomoon-icon-pencil"
        end
      end

      def table_controls_delete_btn(link, confirm = bt("confirm"))
        content_tag :a, :rel => "nofollow", :href => link, :data => { :method => "delete", :confirm => confirm, :hasqtip => true }, :class => "tip delete", :title => bt("delete") do
          tag :span, :class => "icon12 icomoon-icon-remove"
        end
      end

      def table_controls_copy_btn(link)
        content_tag :a, :class => "tip copy", :href => link, "data-hasqtip" => true, "aria-describedby" => "qtip-2", :title => bt("copy") do
          tag :span, :class => "icon12 icomoon-icon-copy-2"
        end
      end

      #
      # action buttons
      #
      def btn_new(name, link)
        content_tag :a, :href => link do
          content_tag :button, :class => "btn btn-primary btn-mini" do
            tag :span, :class => "icomoon-icon-plus white"
            concat(name)
          end
        end
      end

      def btn_submit(name, save_and_new = nil)
        content_tag :button, :class => "btn btn-primary", :type => "submit", :name => "save_and_new", :value => "#{save_and_new}" do
          concat(name)
        end
      end

      def btn_cancel(link)
        content_tag :a, :class => "btn", :href => link do
          concat( bt("cancel") ) # bt in BackendHelper
        end
      end

      def btn_modal_cancel
        capture_haml do
          haml_tag :a, :class => "btn", 'data-dismiss' => 'modal' do
            haml_concat( bt("cancel") ) # bt in BackendHelper
          end
        end
      end


      def active_button(arg = true)
        content_tag :div, :class => "activebutton" do
          tag :input, :type => "checkbox", :checked => ("checked" if arg)
        end
      end

      def backend_modal_render(type,form_object)
        return "" unless ['google','facebook','seo_tags','histories'].include?(type)
        render("mokio/common/modals/modal_#{type}",f: form_object)
      end

      def tab_seo_header
        "#{bt('tabs.seotags')} (#{obj.seo_tags.size})"
      end

      def tab_gallery_header
        "#{bt('tabs.gallery')} (#{obj.data_files.size})"
      end

      def tab_histories_header
        "#{bt('tabs.histories')} (#{obj.history_collection.size})"
      end

      def tab_gmap_header
        bt('tabs.gmap')
      end

      def tab_content_header
        bt('tabs.content')
      end

      def show_tabbed_form?(obj)
        obj.class.try(:has_seo_tagable_enabled?) || 
        obj.class.try(:has_historable_enabled?) || 
        obj.class.try(:has_gmap_enabled?) || 
        obj.class.try(:has_gallery_enabled?)
      end
    end
  end
end