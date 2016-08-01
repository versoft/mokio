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

      #return table name for type
      def generate_tableize_name(type)
        type.gsub!("Mokio::","")
        type.gsub!("::","_") if(type.include? "::")
        type.tableize
      end

    end
  end
end