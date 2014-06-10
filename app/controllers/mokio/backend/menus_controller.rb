module Mokio
  class Backend::MenusController < Backend::CommonController
    after_action :update_related, only: [:update]

    before_action :init_dual_select, only: [:edit, :new, :update, :create]
    before_action :transform_modules, only: [:update, :create]

    def index
      @menus = Menu.includes(:content_links).arrange(:order => :seq)
      super
    end

    def update
      @content_ids = params[:menu][:content_ids]
      @av_mod_ids = params[:menu][:available_module_ids]
      super  
    end

    def update_menu_breadcrumps
      @menu = Menu.find(params[:menu_id])
    end

    def lang_changed
      @menu = Menu.new(:lang_id => params[:lang_id])
      @content_confirm = params[:content_confirm]
      @modules_confirm = params[:modules_confirm]
    end

    def sort
      @change = {}

      transform(params[:menu], @change)

      if Menu.update(@change.keys, @change.values)
        flash[:notice] = t("menus.sort_true")
      else
        flash[:error]  = t("menus.sort_false") 
      end

      render :nothing => true
    end

    private

      def init_dual_select
        @dual_select_str = ""

        ModulePosition.all.each do |mp|
          @dual_select_str += " dualSelectInit('_#{mp.id}', false);"
        end
      end

      # Transforms structure like: menu_id1 => parent_id1, menu_id2 => parent_id2 into 
      # structure like: menu_id => {:parent_id => parent_id, :seq => seq_number}
       def transform(menu_tree_param, change)
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

      def transform_modules
        if !params[:menu][:available_module_ids].nil?
          params[:menu][:available_module_ids] = params[:menu][:available_module_ids].values.flatten
        end
      end

      #
      # after menu is saved, either order of menu articles and selected static modules is saved or they are cleared
      #
      def update_related
        if @menu.errors.empty?
          # raise (@content_ids.inspect)

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

      def menu_params
        params[:menu].permit(:name, :seq, :target, :external_link, :parent_id, :active, :visible, :description, :lang_id, :content_ids => [],:available_module_ids => [],
          :meta_attributes => Meta.meta_attributes)
      end
  end
end
