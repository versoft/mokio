module Mokio
  module Backend
    module CommonHelper

      def has_data_files?(obj)
        obj.respond_to?("data_files") && obj.respond_to?("default_data_file")
      end
     
      def responsive_dynamic_table
        capture_haml do
          haml_tag :table, :data => {:source => datatable_source_url}, :class => "responsive dynamicTable display table table-bordered", :border => 0, :cellpadding => 0, :cellspacing => 0, :width => "100%", :id =>"dTable" do
            yield
          end
        end
      end


      def datatable_source_url
        # with empty return  should work properly
        rescue
          backend_contents_url( format: "json")
      end

      def common_form
        capture_haml do
          haml_tag :div, :class => "form-row row-fluid" do
            haml_tag :div, :class => "span12" do
              yield
            end
          end
        end
      end

      def box_title(name = nil)
        capture_haml do
          haml_tag :div, :class => "title" do
            haml_tag :h4 do
              haml_tag :span, name if name
              yield unless name
            end
          end
        end
      end

      # ======================================================= Buttons
      #
      # controls buttons
      #
      def table_controls_edit_btn(link, from_commons_datatable = false)
        init_haml_helpers if from_commons_datatable
        capture_haml do
          haml_tag :a, :class => "tip", :href => link, "data-hasqtip" => true, "aria-describedby" => "qtip-2", :title => bt("edit") do
            haml_tag :span, :class => "icon12 icomoon-icon-pencil"
          end
        end
      end

      def table_controls_delete_btn(link, confirm = bt("confirm"), from_commons_datatable = false)
        init_haml_helpers if from_commons_datatable
        capture_haml do
          haml_tag :a, :rel => "nofollow", :href => link, :data => { :method => "delete", :confirm => confirm, :hasqtip => true }, :class => "tip", :title => bt("delete") do
            haml_tag :span, :class => "icon12 icomoon-icon-remove"
          end
        end
      end

      def table_controls_copy_btn(link)
        capture_haml do
          haml_tag :a, :class => "tip", :href => link, "data-hasqtip" => true, "aria-describedby" => "qtip-2", :title => bt("copy") do
            haml_tag :span, :class => "icon12 icomoon-icon-copy-2"
          end
        end   
      end

      #
      # action buttons
      #
      def btn_new(name, link)
        capture_haml do
          haml_tag :a, :href => link do
            haml_tag :button, :class => "btn btn-primary btn-mini" do
              haml_tag :span, :class => "icomoon-icon-plus white"
              haml_concat(name)
            end
          end
        end
      end

      def btn_submit(name, save_and_new = nil)
        capture_haml do
          haml_tag :button, :class => "btn btn-primary", :type => "submit", :name => "save_and_new", :value => "#{save_and_new}" do
            haml_concat(name)
          end
        end
      end

      def btn_cancel(link)
        capture_haml do
          haml_tag :a, :class => "btn", :href => link do
            haml_concat( bt("cancel") ) # bt in BackendHelper
          end
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
        capture_haml do
          haml_tag :div, :class => "activebutton" do
            haml_tag :input, :type => "checkbox", :checked => ("checked" if arg)
          end
        end
      end 
    end
  end
end