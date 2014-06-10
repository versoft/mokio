require 'spec_helper'

describe Mokio::Backend::MenuHelper do

  before(:each) do
    @menu = stub_model Menu, :name =>"Testtttt"
    @menu1 = stub_model Menu, :parent => @menu, :name => "Ala"
    helper.extend Haml
    helper.extend Haml::Helpers
    helper.send :init_haml_helpers
  end

  # describe "tree_menu" do
    
  #   it "generates empty menu html" do
  #    expect(tree_menu({}, true)).to eql("")
  #   end

  #   it "generates menu with href to menus" do
  #     @tree = tree_menu({@menu => {@menu1 => {}}}, true)
  #     expect(@tree).to include('<a href="/backend/menus/')
  #     expect(@tree.match("Testtttt").size).to eql(1) 
  #   end

  #   it "generates menu with ol and li elements" do
  #     @tree = tree_menu({@menu => {@menu1 => {}}}, true)
  #     expect(@tree).to include('<li class="sortable_true"')
  #     @tree.should match(/<li.*<div.*Testtttt.*<\/div>.*<ol>.*<\/ol>.*<\/li>.*/xm)
  #   end
  #  end

  # describe "tree_menu_breadcrumb" do

  #   it "generates empty list for new menu" do
  #     @menu2 = Menu.new
  #     expect(tree_menu_breadcrumps(@menu2)).to eql("")
  #   end

  #   it "generates menu with -> and two names" do
  #     @menu = Menu.find_by(:name => "Góra")
  #     @tree = tree_menu_breadcrumps(@menu)
  #     expect(@tree).to match(/<a href=.*\/a> -&gt; <a href=.*\/a>/)
  #   end
  # end

  describe "dual_select_box" do
     it "selected_modules are properly renedered by helper" do
      mod_pos = FactoryGirl.create(:module_position)
      stat_module = FactoryGirl.create(:static_module)
      stat_module.module_positions = [mod_pos]
      stat_module.save
      stat_module = FactoryGirl.create(:static_module)
      stat_module.module_positions = [mod_pos]
      stat_module.save
      av_module = AvailableModule.first
      menu = Menu.new(:name => "Menu777", :parent_id => 1, :lang_id => 1)
      menu.available_modules << av_module
      menu.save
      @col_left = menu.available_modules_by_pos[mod_pos.id]
      @dual = helper.dual_select_box(@col_left, 'id', 'module_title', [av_module], 'id', 'module_title', mod_pos.name, '_' + mod_pos.id.to_s, 'menu[available_module_ids][]', false, true, true, menu.display_editable_field?('available_modules'))
      expect(@dual).to include(av_module.module_title)
    end
  end
end
