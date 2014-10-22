module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods used with Mokio::Menu objects
    #
    module MenuHelper

      #
      # Builds menu tree for specified arguments, returns html
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
        h do |item|
          html << build_items_with_css(item, limit, 1,css_c) if (item.name == position || item.id == position) && item.children.present? && item.active
        end
        html.html_safe
      end


    end
  end
end