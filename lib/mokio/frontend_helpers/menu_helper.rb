module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods used with Mokio::Menu objects
    #
    module MenuHelper

      #
      # Builds menu tree for specified arguments, returns html. Left for backward compatibility. Use build_menu_extended instead.
      #
      # ==== Attributes
      #
      # * +initial_id+ - root's id
      # * +position+   - menu position, root child name or id
      # * +limit+      - how deep should builder look for children, count starts after position
      # * +hierarchical+ - specifies if you want to use hierarchical links or not

      # if you would like to use hierarchical links in your frontend, add following route to your routes.rb

      # get "/*menu_path/:menu_id" => "content#show"
      # get "/:menu_id" => "content#show"

      # ==== Exceptions
      #
      # * +IsNotMenuRootError+ when initial_id is not root's id
      #
      def build_menu(initial_id, position, limit = 1, with_nav = true, nav_class = "navmenu", hierarchical = false)
        root = Mokio::Menu.find_by_id(initial_id)
        #
        # throw exception when initial_id isn't root's id
        #
        raise Exceptions::IsNotMenuRootError.new(:id, initial_id) if root.ancestry
        html = ""
        html = "<nav class='#{nav_class}' id='menuMain'>" if with_nav

        root.children.each do |item|
          html << build_items(item, limit, 1, hierarchical, "") if (item.name == position || item.id == position) && item.children.present? && item.active
        end

        html << "</nav>"  if with_nav
        html.html_safe
      end

      #
      # Builds menu tree for specified arguments, returns html
      #
      # ==== Attributes
      #
      # * +initial_name+ - parent menu position name
      # * +limit+      - how deep should builder look for children, count starts after position
      #

      def build_menu_by_name(initial_name,limit = 1)
        lang = Mokio::Lang.default
        position = Mokio::Menu.find_by_lang_id_and_name(lang.id,initial_name)

        html = "<nav class='navmenu' id='menuMain'>"
        html << build_items(position, limit, 1) if position.children.present? && position.active
        html << "</nav>"
        html.html_safe

      end

      #
      # Recursive building menu items
      #
      # ==== Attributes
      #
      # * +item+  - Mokio::Menu object
      # * +limit+ - how deep should builder look for children
      # * +index+ - how deep is function already
      #

      def build_items(item, limit, index, hierarchical  = false, root_path = "")
        return "" if index > limit || !item.children.present?

        html = "<ul class='#{index == 1 ? "menu" : "sub-menu"}'>"
        item.children.order_default.each do |i|
          if i.visible && i.active
            html << "<li class='#{"menu-item-has-children" if i.children.present?} #{"active" if i.slug == params[:menu_id] || i.slug == request.original_fullpath.match(/(\D+\/{1}|\D+)/)[0].gsub('/', '')}'>"

            if i.external_link.blank?
              if hierarchical
                html << "<a href='#{root_path}/#{i.slug}'>#{i.name}</a>"
              else
                html << "<a href='/#{i.slug}'>#{i.name}</a>"
              end
            else
              html << "<a href='#{i.external_link}' rel='#{(i.follow || i.follow.nil?) ? "follow" : "nofollow"}' target='#{i.target.blank? ? '_self' : i.target}'>#{i.name}</a>"
            end

            html << build_items(i, limit, index + 1, hierarchical, root_path + "/#{i.slug}")
            html << "</li>"
          end
        end
        html << "</ul>"
        html.html_safe
      end

      alias_method :create_menu, :build_menu

      #
      # Finds proper menu element - based on lang and menu position and calls build_menu_extended for this menu element
      #

      def build_menu_extended_lang(menu_position_name, lang_code, limit = 999999, include_menu_parent = false, options = {hierarchical: true, with_nav: true, nav_class: "nav_menu", active_class: "active", item_class: nil, item_with_children_class: nil, item_without_children_class: nil, ul_class: nil, ul_wrapper_class: nil, ul_nested_class:nil, ul_nested_wrapper_class:nil, a_class: nil})
        lang = Mokio::Lang.find_by_shortname(lang_code)
        menu_parent = Mokio::Menu.where(lang_id: lang.id, name: menu_position_name) unless lang.blank?
        build_menu_extended(menu_parent.first.id, limit, include_menu_parent, options) unless menu_parent.blank?
      end


      #
      # Builds menu tree for specified arguments, returns html. Allows specifying css classes and start from any menu element.
      # Menu structure:
      # <nav> (optional)
      #   <div class='#{ul_wrapper_class}'>
      #     <ul class='#{ul_class}'>
      #       <div class='#{item_wrapper_class}'> (optional)
      #         <li class='#{item_class} #{item_with_children_class} #{active_class}'>
      #            <a>item.slug or item.full_slug</a>
      #           <div class='#{ul_nested_wrapper_class}'>
      #             <ul class="#{ul_nested_class}">
      #               <li class='#{item_class}#{item without_children_class}'>
      #                 <a class='#{active_class}'>item.slug or item.full_slug</a>
      #               </li>
      #               <li class='#{item_class}#{item without_children_class}'
      #                 <a class='#{active_class}'>item.slug or item.full_slug</a>
      #               </li>
      #             </ul>
      #           </div>
      #         </li>
      #       </div>
      #       <li class='#{item_class}#{item without_children_class}'>
      #         <a class='#{active_class}'>item.slug or item.full_slug</a>
      #       <li>
      #     </ul>
      #   </div>
      # </nav>
      #
      # ==== Attributes
      #
      # * +menu_parent_id+ - starting menu element's id - this element will be displayed or not and all its children will be displayed
      # * +include_menu_parent+ - whether parent menu element should be displayed or not
      # * +limit+      - how deep should builder look for children, count starts from 1
      # * +options+   - hash with following options:
      # *   +hierarchical+ - specifies if you want to use hierarchical links or not
      # *   +with_nav+  - whether nav element should be generated
      # *   +nav_class+  - css class of the nav element
      # *   +active_class+  - css class of the active items
      # *   +item_class+  - css class of the items
      # *   +item_with_children_class+  - css class of the items that have children
      # *   +item_without_children_class+  - css class of the items without children
      # *   +ul_class+  - css class of the ul element
      # *   +ul_wrapper_class+ - css class of the ul wrapper class, if nil then wrapper for ul will not be generated
      # *   +ul_nested_class+  - css class of the nested ul element
      # *   +ul_nested_wrapper_class+ - css class of the ul wrapper class, generated only for nested uls, if nil then wrapper for nested ul will not be generated
      # *   +a_class+ - css class of the a element
      #*    +content_type+ - content types for which we'll build menu items(string or array e.g. "Mokio::Article" OR ["Mokio::Article", "Mokio::PicGallery"])
      #*    +content_item_class+ - css class of the content items (not Mokio::Menu, specified above)

      # if you need hierarchical links in your frontend, add following route to your routes.rb

      # get "/*menu_path/:menu_id" => "content#show"
      # get "/:menu_id" => "content#show"

      def build_menu_extended(menu_parent_id, limit = 999999, include_menu_parent = false, options = {})

        set_options_defaults(options)

        html = ""
        html = "<nav #{"class='#{options[:nav_class]}'" if options[:nav_class]} id='menuMain'>" if options[:with_nav]
        html << "<div class='#{options[:ul_wrapper_class]}'>" unless options[:ul_wrapper_class].nil?
        html << "<ul #{"class='#{options[:ul_class]}'" if options[:ul_class]}>"
        begin
          menu_parent = Mokio::Menu.find(menu_parent_id)
          if include_menu_parent
            html << build_menu_items_extended(menu_parent, limit, 1, menu_parent.ancestor_ids, options)
          else
            menu_parent.children.order_default.each do |i|
              html << build_menu_items_extended(i, limit, 1, i.ancestor_ids, options)
            end
          end

        rescue => e
          MOKIO_LOG.error "BUILD MENU ERROR: #{e}"
        end
        html << "</ul>"
        html << "</div>" unless options[:ul_wrapper_class].nil?
        html << "</nav>"  if options[:with_nav]
        html.html_safe
      end

      # Builds menu starting from given menu element (real menu only)
      # - displays all its children

      def build_menu_items_extended (i, limit, index, active_ids = [], options)

        return "" if index > limit

        html = ""
        if i.visible && i.active
          item_class = build_item_class(i, options, active_ids)
          html << "<li #{"class='#{item_class}'" unless item_class.blank?}>"

          if i.external_link.blank?
            html << "<a #{"class='#{options[:a_class]}'" if options[:a_class]} href='#{i.real_slug(options[:hierarchical])}'>#{i.name}</a>"
          else
            html << "<a #{"class='#{options[:a_class]}'" if options[:a_class]} href='#{i.external_link}' #{"rel='nofollow'" unless i.follow  || i.follow.nil?} #{"target='#{i.target}'" unless (i.target.blank? || i.target == '_self') }>#{i.name}</a>"
          end

          items_html = ""

          i.children.order_default.each do |item_child|
            items_html << build_menu_items_extended(item_child, limit, index + 1, active_ids, options)
          end

          content_item_class = [item_class, options[:content_item_class]].compact.join(" ")
          i.contents.displayed.order_default.each do |content|
            next if options[:content_type].blank? || options[:content_type].exclude?(content.type.to_s)
            items_html << "<li #{"class='#{content_item_class}'" unless content_item_class.blank?}>"
            items_html << "<a #{"class='#{options[:a_class]}'" if options[:a_class]} href='#{content.slug}'>#{content.title}</a>" if content.respond_to?("slug")
            items_html << "</li>"
          end

          unless items_html.empty?
            html << "<div class='#{options[:ul_nested_wrapper_class]}'>" unless options[:ul_nested_wrapper_class].nil?
            html << "<ul #{"class='#{options[:ul_nested_class]}'" if options[:ul_nested_class]}>"
            html << items_html
            html << "</ul>"
            html << "</div>" unless options[:ul_nested_wrapper_class].nil?
          end
          html << "</li>"
        end
        html.html_safe
      end


      # Builds css class fot one menu item

      def build_item_class(i, options, active_ids)

        item_class = []

        item_class << options[:item_class]
        item_class << i.css_class

        if i.has_children?
          item_class << options[:item_with_children_class]
        else
          item_class << options[:item_without_children_class]
        end

        item_class << options[:active_class] if i.slug == params[:menu_id] || i.slug == request.original_fullpath.match(/(\D+\/{1}|\D+)/)[0].gsub('/', '') || active_ids.include?(i.id)
        item_class.compact.join(" ")
      end


      # Sets default values for build_menu_extended

      def set_options_defaults(options)
        options[:hierarchical] = true unless options.has_key? :hierarchical
        options[:with_nav] = true unless options.has_key? :with_nav
        options[:nav_class] = "nav_menu" unless options.has_key? :nav_class
        options[:active_class] =  "active" unless options.has_key? :active_class
        options[:content_type] = "" unless options.has_key? :content_type
      end


      #
      # Raises IsNotAMokioMenuErrorr if obj isn't a Mokio::Menu object
      #
      # ==== Attributes
      #
      # * +obj+ - any object
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioMenuError+ when obj is not a Mokio::Menu object
      #
      def isMenu?(obj)
        raise Exceptions::IsNotAMokioMenuError.new(obj) unless obj.is_a?(Mokio::Menu)
      end

      #
      # Returns all contents added to menu
      #
      # ==== Attributes
      #
      # * +menu+ - Mokio::Menu object
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioMenuError+ when obj is not a Mokio::Menu object
      #
      def menu_content_all(menu)
        isMenu?(menu)
        menu.contents
      end

      #
      # Returns active contents added to menu
      #
      # ==== Attributes
      #
      # * +menu+ - Mokio::Menu object
      # * +limit+ - Limit contents count
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioMenuError+ when obj is not a Mokio::Menu object
      #
      def menu_content(menu, limit = nil)
        isMenu?(menu)
        contents   = menu.contents.active unless limit
        contents ||= menu.contents.active.limit(limit)
        contents
      end

      #
      # Returns active contents titles added to menu
      #
      # ==== Attributes
      #
      # * +menu+ - Mokio::Menu object
      # * +limit+ - Limit contents count
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioMenuError+ when obj is not a Mokio::Menu object
      #
      def menu_content_titles(menu, limit = nil)
        isMenu?(menu)
        contents = menu_content(menu, limit)
        titles   = []

        contents.each do |c|
          titles << c.title
        end

        titles
      end

      #
      # Returns static_modules added to menu
      #
      # ==== Attributes
      #
      # * +menu+ - Mokio::Menu object
      # * +limit+ - Limit static_modules count
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioMenuError+ when obj is not a Mokio::Menu object
      #
      def menu_static_modules(menu, limit = nil)
        isMenu?(menu)
        modules   = menu.static_modules unless limit
        modules ||= menu.static_modules.limit(limit)
        modules
      end

      #
      # Returns static_modules titles added to menu
      #
      # ==== Attributes
      #
      # * +menu+ - Mokio::Menu object
      # * +limit+ - Limit static_modules count
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioMenuError+ when obj is not a Mokio::Menu object
      #
      def menu_static_modules_titles(menu, limit = nil)
        isMenu?(menu)
        modules = menu_static_modules(menu, limit)
        titles  = []

        modules.each do |m|
          titles << m.title
        end

        titles
      end

      #
      # Returns menus slug
      #
      # ==== Attributes
      #
      # * +menu+ - Mokio::Menu object
      #
      # ==== Exceptions
      #
      # * +IsNotAMokioMenuError+ when obj is not a Mokio::Menu object
      #
      def menu_slug(menu)
        isMenu?(menu)
        menu.slug
      end

      #
      # Returns menu root id for active locale, raises IsNotMenuRootError when root was not found
      #
      # ==== Exceptions
      #
      # * +IsNotMenuRootError+ when initial_id is not root's id
      #
      def menu_locale_root_id
        begin
          Mokio::Menu.find_by_name(I18n.locale).id
        rescue ActiveRecord::RecordNotFound, NoMethodError
          raise Exceptions::IsNotMenuRootError.new(:name, I18n.locale)
        end
      end

      #
      # Returns menu root id for given name, raises IsNotMenuRootError when root was not found
      #
      # ==== Attributes
      #
      # * +name+ - searched menu name
      #
      # ==== Exceptions
      #
      # * +IsNotMenuRootError+ when initial_id is not root's id
      #
      def menu_root_id(name)
        begin
          root = Mokio::Menu.find_by_name(name)
          raise Exceptions::IsNotMenuRootError.new(:name, name) if root.ancestry
          root.id
        rescue ActiveRecord::RecordNotFound, NoMethodError
          raise Exceptions::IsNotMenuRootError.new(:name, name)
        end
      end


      def build_items_with_css(item, limit, index ,css_c)
        return "" if index > limit || !item.children.present?


        html = "<ul class='#{index == 1 ? css_c[0] :  css_c[1]}'>"
        item.children.order_default.each do |i|
          if i.visible && i.active
            html << "<li class='#{ css_c[2]  if i.children.present?} #{"active" if i.slug == params[:menu_id] || i.slug == request.original_fullpath.match(/(\D+\/{1}|\D+)/)[0].gsub('/', '')}'>"

            if i.external_link.blank?
              html << "<a href='/#{i.slug}'>#{i.name}</a>"
            else
              html << "<a href='#{i.external_link}' rel='#{i.follow ? "follow" : "nofollow"}' target='#{i.target.blank? ? '_self' : i.target}'>#{i.name}</a>"
            end
            html << build_items_with_css(i, limit, index + 1,css_c)

            html << "</li>"
          end
        end
        html << "</ul>"
        html.html_safe
      end


      def build_menu_with_css(initial_id, position, limit = 1, css_c = false)

        if css_c == false
          css_c = ["menu","sub-menu","menu-item-has-children"]
        end

        root = Mokio::Menu.find_by_id(initial_id)
        #
        # throw exception when initial_id isn't root's id
        #
        raise Exceptions::IsNotMenuRootError.new(:id, initial_id) if root.ancestry
        html = ""
        root.children.each do |item|
          html << build_items_with_css(item, limit, 1,css_c) if (item.name == position || item.id == position) && item.children.present? && item.active
        end
        html.html_safe
      end


    end
  end
end