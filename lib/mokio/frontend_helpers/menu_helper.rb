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
      #
      # ==== Exceptions
      #
      # * +IsNotMenuRootError+ when initial_id is not root's id
      #
      def build_menu(initial_id, position, limit = 1, with_nav = true, nav_class="navmenu")
        root = Mokio::Menu.find_by_id(initial_id)
        #
        # throw exception when initial_id isn't root's id
        #
        raise Exceptions::IsNotMenuRootError.new(:id, initial_id) if root.ancestry
        html = ""
        html = "<nav class='#{nav_class}' id='menuMain'>" if with_nav

        root.children.each do |item|
          html << build_items(item, limit, 1) if (item.name == position || item.id == position) && item.children.present? && item.active
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
      def build_items(item, limit, index)
        return "" if index > limit || !item.children.present?

        html = "<ul class='#{index == 1 ? "menu" : "sub-menu"}'>"
        item.children.order_default.each do |i|
          if i.visible && i.active
            html << "<li class='#{"menu-item-has-children" if i.children.present?} #{"active" if i.slug == params[:menu_id] || i.slug == request.original_fullpath.match(/(\D+\/{1}|\D+)/)[0].gsub('/', '')}'>"

            if i.external_link.blank?
              html << "<a href='/#{i.slug}'>#{i.name}</a>"
            else
              html << "<a href='#{i.external_link}' rel='#{i.follow ? "follow" : "nofollow"}' target='#{i.target.blank? ? '_self' : i.target}'>#{i.name}</a>"
            end
            html << build_items(i, limit, index + 1)

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
      # * +limit+ - Limit contents count
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
      # * +limit+ - Limit contents count
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
    end
  end
end