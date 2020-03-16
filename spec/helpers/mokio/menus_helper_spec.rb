require 'spec_helper'
include Mokio::Backend::BackendHelper
include Mokio::Backend::CommonHelper
include Mokio::Backend::UrlHelper

module Mokio

  describe Mokio::Backend::MenuHelper, type: :helper do

    before(:each) do
      @routes = Mokio::Engine.routes
      @menu = stub_model Menu, :name => "Testtttt"
      @menu1 = stub_model Menu, :parent => @menu, :name => "Ala"
      # helper.extend Haml
      # helper.extend Haml::Helpers
      # helper.send :init_haml_helpers
    end

    describe "tree_menu" do

      it "generates empty menu html" do
       expect(tree_menu({}, true)).to eql("")
      end

      it "generates menu with href to menus" do
        @tree = tree_menu({@menu => {@menu1 => {}}}, true)
        expect(@tree).to match(/<a href=".*\/menus\//)
        expect(@tree.match("Testtttt").size).to eql(1)
      end

      it "generates menu with ol and li elements" do
        @tree = tree_menu({@menu => {@menu1 => {}}}, true)
        expect(@tree).to include('class="sortable_true"')
        @tree.should match(/<li.*<div.*Testtttt.*<\/div>.*<ol>.*<\/ol>.*<\/li>.*/xm)
      end
    end

    describe "tree_menu_breadcrumb" do

      it "generates empty list for new menu" do
        @menu2 = Menu.new
        expect(tree_menu_breadcrumbs(@menu2)).to eql("")
      end

      # it "generates menu with -> and two names" do
      #   @menu = FactoryBot.create(:menu, :name => "Tralalala")
      #   @menu1 = FactoryBot.create(:menu, :name => "Tralalala1", :parent => @menu)
      #   @tree = tree_menu_breadcrumbs(@menu1)
      #   expect(@tree).to match(/<a href=.*\/a> -&gt; <a href=.*\/a>/)
      # end
    end

    describe "dual_select_box" do
       it "selected_modules are properly renedered by helper" do
        mod_pos = FactoryBot.create(:module_position)
        stat_module = FactoryBot.create(:static_module)
        stat_module.module_positions = [mod_pos]
        stat_module.save
        stat_module = FactoryBot.create(:static_module)
        stat_module.module_positions = [mod_pos]
        stat_module.save
        av_module = AvailableModule.first
        FactoryBot.create(:lang_pl)
        menu = Menu.new(:name => "Menu777", :parent_id => 1, :lang_id => 1)
        menu.available_modules << av_module
        menu.save
        @col_left = menu.available_modules_by_pos[mod_pos.id]
        @dual = helper.dual_select_box(@col_left, 'id', 'module_title', [av_module], 'id', 'module_title', mod_pos.name, '_' + mod_pos.id.to_s, 'menu[available_module_ids][]', false, true, true, menu.display_editable_field?('available_modules'))
        expect(@dual).to include(av_module.module_title)
      end
    end
  end
end