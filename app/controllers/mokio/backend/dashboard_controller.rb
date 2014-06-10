# -*- encoding : utf-8 -*-
module Mokio
  class Backend::DashboardController < Backend::BaseController
    load_and_authorize_resource :class => "Content"  
    
    def show
      #
      # not assigned content
      #
      @loose_content      = Content.includes(:menus).where(:content_links => {:content_id => nil}).where.not(:home_page => true)
      @more_loose_content = @loose_content.size
      @loose_content      = @loose_content.first(Mokio.dashboard_size.to_i)

      #
      # menu without displayed content
      #
      @menu_with_invisible_content = (Menu.includes(:contents).where('contents.id is not NULL').references(:contents)).select{|menu| menu.invisible_content}
      @empty_menu = Menu.includes(:contents).where(:content_links => {:menu_id => nil}, :external_link => nil, :fake => false)
      @empty_menu = @empty_menu.concat(@menu_with_invisible_content)
      @empty_menu = @empty_menu.first(Mokio.dashboard_size.to_i)
      @more_empty_menu = @empty_menu.size

      @last_created  = Content.limit(Mokio.dashboard_size.to_i).order('created_at desc')
      @last_updated  = Content.limit(Mokio.dashboard_size.to_i).order('updated_at desc')
      @static_module = StaticModule.includes(:positions).where('positions.id IS NULL').references(:contents)
    end
  end
end