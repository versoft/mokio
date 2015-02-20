module Mokio 
  module Concerns
    module Controllers
      #
      # Concern for MenusController
      #
      # * +before filters:+
      # :init_dual_select, only: [:edit, :new, :update, :create]
      # :transform_modules, only: [:update, :create]
      #
      # * +after filters:+
      # :update_related, only: [:update]
      #
      module Menus
        extend ActiveSupport::Concern

        included do
          before_action :init_dual_select, only: [:edit, :new, :update, :create]
          before_action :transform_modules, only: [:update, :create]

          after_action :update_related, only: [:update]
        end

        #
        # extended CommonController#index (Mokio::Concerns::Controllers::Common)
        #
        def index
          @menus = Mokio::Menu.includes(:content_links).arrange(:order => :seq)
          super
        end

        #
        # extended CommonController#update (Mokio::Concerns::Controllers::Common)
        #
        def update
          @content_ids = params[:menu][:content_ids]
          @av_mod_ids = params[:menu][:available_module_ids]
          super  
        end

        #
        # Ajax updating breadcrumps in menus edit/new
        #
        def update_menu_breadcrumps
          @menu = Mokio::Menu.find(params[:id])
        end

        #
        # Ajax changing lang
        #
        def lang_changed
          @menu = Mokio::Menu.new(:lang_id => params[:lang_id])
          @content_confirm = params[:content_confirm]
          @modules_confirm = params[:modules_confirm]
        end

        #
        # Ajax sorting menus tree
        #
        def sort
          @change = {}

          transform(params[:menu], @change)

          if Mokio::Menu.update(@change.keys, @change.values)
            flash[:notice] = t("menus.sort_true")
          else
            flash[:error]  = t("menus.sort_false") 
          end

          render :nothing => true
        end

        # Renders form for creating menu positon (fake menu - direct child of a lang root)

        def new_menu_position
          @menu = Mokio::Menu.new
        end

        def create_menu_position
          parent = Mokio::Menu.where(lang_id: params[:menu][:lang_id], ancestry: nil).first
          params[:menu][:parent_id] = parent.id
          params[:menu][:deletable] = true
          create
        end

        private
          #
          # Method to initialize menu's dual select boxes
          #
          def init_dual_select #:doc:
            @dual_select_str = ""

            Mokio::ModulePosition.all.each do |mp|
              @dual_select_str += " dualSelectInit('_#{mp.id}', false);"
            end
          end

          #
          # Transforms structure like: menu_id1 => parent_id1, menu_id2 => parent_id2 into 
          # structure like: menu_id => {:parent_id => parent_id, :seq => seq_number}
          #
           def transform(menu_tree_param, change) #:doc:
            seq      = {}
            menus    = Menu.all
            root_ids = menus.select{|m| !m.ancestry.blank? && /\//.match(m.ancestry).nil? }.collect{|m| m.id}

            menu_tree_param.each do |menu_id, parent_id|
              menu = menus.select{|m| m.id == menu_id.to_i}.first
              # parent_id = menu.lang_id if parent_id == 'null'
               
              if parent_id == "null"
                parent_id = menu.ancestor_ids.select{|ar| root_ids.include?(ar)}.first
              end

              seq[parent_id] = seq[parent_id].nil? ? 1 : seq[parent_id].to_i + 1
              change[menu_id] = {:parent_id => parent_id, :seq => seq[parent_id]} 
            end

            change
          end

          def transform_modules #:doc:
            if !params[:menu][:available_module_ids].nil?
              av_module_ids = params[:menu][:available_module_ids].values.flatten

              # modules that are always displayed are not saved as selected_modules

              av_modules = AvailableModule.where('id IN (?)', av_module_ids)
              av_modules.each do |mod|
                if mod.static_module.always_displayed
                  av_module_ids.delete(mod.id.to_s)
                end
              end
              params[:menu][:available_module_ids] = av_module_ids
            end
          end

          #
          # After menu is saved, either order of menu articles and selected static modules is saved or they are cleared
          #
          def update_related #:doc:
            if @menu.errors.empty?
              if @content_ids.nil?
                @menu.contents = []
              else
                @menu.content_links.each do |content_link|
                  pos = @content_ids.find_index(content_link.content_id.to_s)
                  pos = pos.nil? ? 0 : pos
                  content_link.set_list_position(pos + 1)
                end
              end

              if @av_mod_ids.nil?
                @menu.available_modules = []
              else
                @menu.selected_modules.each do |mod|
                  pos = @av_mod_ids.find_index(mod.available_module_id.to_s)
                  pos = pos.nil? ? 0 : pos
                  mod.set_list_position(pos + 1)
                end
              end

              @menu.save
            end
          end
          
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def menu_params #:doc:
            params[:menu].permit(:name, :subtitle, :seq, :target, :external_link, :follow, :parent_id, :active, :visible, :description, :lang_id, :fake, :content_ids => [],:available_module_ids => [],
              :meta_attributes => Mokio::Meta.meta_attributes)
          end
      end
    end
  end
end