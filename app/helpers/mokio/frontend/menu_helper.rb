module Mokio
  module Frontend
    module MenuHelper
      #
      # initial_id - root's id
      # position   - menu position, root child name or id
      # limit      - how deep should builder look for children, count starts after position 
      #
      def build_menu(initial_id, position, limit = 1)
        capture_haml do
          root = Menu.find(initial_id)

          haml_tag :nav, :class => "navmenu" do
            root.children.each do |item|
              build_items(item, limit, 1) if (item.name == position || item.id = position) && item.children.present? && item.active
            end
          end
        end
      end

      def build_items(item, limit, index)
        return if index > limit || !item.children.present?

        haml_tag :ul, :class => (index == 1 ? "menu" : "sub-menu") do
          item.children.order_default.each do |i|
            if i.visible && i.active
              haml_tag :li, :class => ("menu-item-has-children #{"current-menu-item" if i.slug == params[:menu_id]}" if i.children.present?) do
                if i.external_link.blank?
                  haml_tag :a, :href => "/#{i.slug}" do
                    haml_concat(i.name)
                  end
                else
                  haml_tag :a, :href => "#{i.external_link}", :rel => i.follow ? "follow" : "nofollow" do
                    haml_concat(i.name)
                  end
                end
                build_items(i, limit, index + 1)
              end
            end
          end
        end
      end

      alias_method :create_menu, :build_menu
    end
  end
end