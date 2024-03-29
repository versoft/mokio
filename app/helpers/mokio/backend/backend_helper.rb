module Mokio
  module Backend
    module BackendHelper
      include Haml::Helpers
      #
      # Translate methods
      #
      def bt( title, from_modal_name = nil )
        t( from_modal_name.nil? ? "backend.#{title}" : "#{from_modal_name.to_s.tableize}.#{title}".gsub("mokio/", "") )
      end

      def btc( title, from_modal_name = nil )
        bt(title, from_modal_name).capitalize
      end

      #
      # Sidebar button translate method
      #
      def bts(title)
        bt(title, "backend.sidebar")
      end

      def engine_root
        Mokio::Engine.routes.url_helpers.root_path
      end

      # Generate sidebar button
      # ==== Examples
      # For <code>sidebar_btn Mokio::Menu, "icomoon-icon-menu-2"</code>
      # it generates:
      #   <li class="menu_nav">
      #     <a href="/backend/menus">
      #       <span class="icon16 icomoon-icon-menu-2"></span>Menu
      #     </a>
      #     <a href="/backend/menus/new">
      #       <span class="icon14 icomoon-icon-plus"></span>
      #     </a>
      #   </li>
      #
      # For <code>sidebar_btn Mokio::Menu, "icomoon-icon-menu-2", false</code>
      # it generates:
      #   <li class="menu_nav">
      #     <a href="/backend/menus">
      #       <span class="icon16 icomoon-icon-menu-2"></span>Menu
      #     </a>
      #   </li>
      #
      # ==== Attributes
      #
      # * +type+ - Item type i.e. Mokio::Menu
      # * +label+ - Item label. I.e if empty? for Mokio::Menu => <code>bts("menu" )</code>
      # * +icon_class+ - Icon css class i.e. "icomoon-icon-earth"
      # * +add_btn+ - Determines whether generate "+" button
      # * +check_permissions+ - Determines whether check permissions
      #     i.e.(can? : manage, Mokio::Menu)
      # * +plus_icon_class+ Icon css class for "+" button
      def sidebar_btn(type, icon_class, label="", add_btn = true, check_permissions = true, plus_icon_class = "icomoon-icon-plus")

        table = generate_tableize_name(type.to_s) #Mokio::Menu => menus or Mokio::MyModule::Menu => mymodule_menus
        model = table.singularize#Mokio::Menu => menu

        if label.empty?
          label = bts(model)
        end
        create_btn  = add_btn
        manage_btn = true

        can_manage = can? :manage, type
        can_create = can? :create, type

        if check_permissions
          unless can_manage
            manage_btn &&= false
          end
          unless can_create
            create_btn &&= false
          end
        end
        html = ""
        if create_btn || manage_btn
          # we always add manage btn
          html << "<li class='#{model}_nav'>"
          manage_path = send(table + "_path")
          html << <<-HTML
          <a href="#{manage_path}">
            <span class="icon16 #{icon_class}"></span>#{label}
          </a>
          HTML
          if create_btn
            create_path = send("new_" + model + "_path")
            html << <<-HTML
            <a href="#{create_path}">
              <span class="icon14 #{plus_icon_class}"></span>
            </a>
            HTML
          end
          html << "</li>"
        end
        html.html_safe
      end

      #
      # Can user manage any site elements
      #
      def can_manage_site_elements?
        (
          (can? :manage, Mokio::StaticModule) ||
          (can? :create, Mokio::StaticModule) ||
          (can? :manage, Mokio::ModulePosition) ||
          (can? :create, Mokio::ModulePosition) ||
          (can? :manage, Mokio::ExternalScript) ||
          (can? :create, Mokio::ExternalScript)
        )
      end

      #return table name for type
      def generate_tableize_name(type)
        type.gsub!("Mokio::","")
        type.gsub!("::","_") if(type.include? "::")
        type.tableize
      end

      def set_sorting_param(obj_class)
        if obj_class.respond_to? :default_datatable_sorting
          obj_class.default_datatable_sorting
        else
          [[0, 'asc']]
        end
      end

      # COMMON INPUTS HELPERS

      def render_backend_input_lang_id(f)
        f.input(
          :lang_id,
          collection: Mokio::Lang.all.collect{|lang| [bt(lang.name), lang.id]},
          include_blank: bt('all'),
          disabled: !obj.display_editable_field?('lang_id'),
          wrapper: :select2
        )
      end

      def render_ckeditor_field(f, params)
        params[:ckeditor_height] = 400 unless params[:ckeditor_height]
        params[:disabled] = false unless params[:disabled]
        if Mokio.use_ckeditor5
          ### CKEDITOR 5 ###
          params[:ckeditor_name] = 'mini' unless params[:ckeditor_name]
          form_hash = {
            input_html: {
              data: {
                ckeditor5: params[:ckeditor_name],
                height: params[:ckeditor_height]
              }
            },
            disabled: params[:disabled]
          }
          form_hash[:label] = params[:label] if params[:label]
          form_hash[:input_html][:value] = params[:value] if params[:value]
          f.input(
            params[:input_name],
            form_hash
          )
        else
          ### CKEDITOR 4 ###
          params[:ckeditor_name] = 'Mini' unless params[:ckeditor_name]
          form_hash =  {
            wrapper: :ckeditor,
            as: :ckeditor,
            input_html: {
              ckeditor: {
                toolbar: params[:ckeditor_name].capitalize,
                height: params[:ckeditor_height],
                language: I18n.locale
              }
            },
            disabled: params[:disabled]
          }

          form_hash[:label] = params[:label] if params[:label]
          form_hash[:value] = params[:value] if params[:value]

          f.input(
            params[:input_name],
            form_hash
          )
        end
      end

      def render_backend_input_active(f)
        render_backend_input_active_checkbox(f,'active')
      end

      def render_backend_input_home_page(f)
        render_backend_input_active_checkbox(f,'home_page')
      end

      def render_backend_input_active_checkbox(f,name)
        f.input name.to_sym,:wrapper => :active_checkbox, disabled: !obj.display_editable_field?("#{name}")
      end

      def gallery_title(obj)
        obj.try(:gallery_title) || obj.try(:title) || bt('gallery', obj.class)
      end

      def active_view_switch_helper(bool,obj)

        class_name = (obj.class.name.include? "Mokio::") ? obj.class.name.gsub("Mokio::", "") : obj.class.name
        #check is class in Mokio module
        obj_class = "Mokio::#{class_name.gsub("Controller", "").classify}".constantize rescue nil
        #if there is no class in Mokio module check outside
        if obj_class.nil?
            obj_class = "#{class_name.gsub("Controller", "").classify}".constantize rescue nil
        end
        #used for path to update_active action in datatable.js.coffee.erb
        obj_path = ((obj_class.to_s.include? "Mokio::") ? obj_class.to_s.gsub("Mokio::","") : obj_class.to_s).tableize
        obj_id = obj.id.to_s

        return "<div class=\"activebutton\">
        <input type=\"checkbox\"
          #{"checked=\"checked\"" if bool}
          class=\"activebtn switch-small\"
          data-on=\"success\"
          data-off=\"danger\"
          data-on-label=\"<i class='icomoon-icon-checkmark white'></i>\"
          data-off-label=\"<i class='icomoon-icon-cancel-3 white'></i>\"
          #{"data-object-class='" + obj_path + "'"}
          #{"data-object-id='" + obj_id + "'"}
        >
      </div>"
      .html_safe
      end

      def mokio_filters_enabled?(obj_class)
        obj_class.respond_to?(:filter_index_config) &&
        !obj_class.filter_index_config.blank?
      end

      def object_attribute_trans_key(obj, field_sym)
        [
          'activerecord.attributes',
          obj.name.tableize.singularize,
          field_sym.to_s
        ].join('.')
      end
    end
  end
end
