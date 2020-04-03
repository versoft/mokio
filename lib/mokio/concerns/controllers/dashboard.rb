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

          # advanced dashboard

          @advanced_dashboard = collect_advanced_dashboard
        end

        private

        def collect_advanced_dashboard
          return [] unless Mokio.mokio_advanced_dashboard_enabled

          collected = []
          config_models = Mokio.mokio_advanced_dashboard_models
          config_models.each do |key,val|

            begin
              model = key.classify.constantize
            rescue => e
              raise "Advanced dashboard model error: #{e.inspect}"
              return []
            end

            begin
              item = {}

              names = %w(actions columns translations)
              names.map{|a| item[a.to_sym] = val["#{a}"]}

              item[:collection] = model.all.order(id: :desc).limit(5)
              item[:model] = model
              collected << item
            rescue => e
              puts "Advanced dashboard collect records error: #{e.inspect}"
            end
          end
          return collected
        end
      end
    end
  end
end
