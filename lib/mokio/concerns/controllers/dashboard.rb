module Mokio
  module Concerns
    module Controllers
      #
      # Concern for DashboardController. Devise's load_and_authorize_resource is also placed here.
      #
      module Dashboard
        extend ActiveSupport::Concern

        included do
          load_and_authorize_resource :class => "Mokio::Content"
        end

        #
        # Standard show action
        #
        def show
          #
          # not assigned content
          #
          @loose_content      = Mokio::Content.includes(:menus).where(:mokio_content_links => {:content_id => nil}).where.not(:home_page => true)
          @more_loose_content = @loose_content.size
          @loose_content      = @loose_content.first(Mokio.dashboard_size.to_i)

          #
          # menu without displayed content
          #
          @menu_with_invisible_content = (Mokio::Menu.includes(:contents).where('mokio_contents.id is not NULL').references(:contents)).select{|menu| menu.invisible_content}.pluck :id
          @empty_menu = Mokio::Menu.includes(:contents).where(:mokio_content_links => {:menu_id => nil}, :external_link => nil, :fake => false).pluck :id
          @empty_menu = Mokio::Menu.where id: @empty_menu + @menu_with_invisible_content
          @empty_menu = @empty_menu.first(Mokio.dashboard_size.to_i)
          @more_empty_menu = @empty_menu.size

          @last_created  = Mokio::Content.limit(Mokio.dashboard_size.to_i).order('created_at desc')
          @last_updated  = Mokio::Content.limit(Mokio.dashboard_size.to_i).order('updated_at desc')
          @static_module = Mokio::StaticModule.includes(:positions).where('positions.id IS NULL').references(:contents)
        end
      end
    end
  end
end
