# == Schema Information
#
# Table name: menus
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  active           :boolean          default(TRUE)
#  seq              :integer
#  target           :string(255)
#  external_link    :string(255)
#  lang_id          :integer
#  editable         :boolean          default(TRUE)
#  deletable        :boolean          default(TRUE)
#  visible          :boolean          default(TRUE)
#  position_id      :integer
#  ancestry         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)
#  content_editable :boolean          default(TRUE)
#  modules_editable :boolean          default(TRUE)
#  fake             :boolean          default(FALSE)
#  slug             :string(255)
#

require 'spec_helper'

MENU_COUNT_INITIAL = 7

module Mokio

describe Menu do

  before :each do
    FactoryBot.create(:lang_pl)
  end

  it "has one record" do
    expect {FactoryBot.create(:menu)}.to change(Menu, :count).by(1)
  end

  it "counts only records that match a query" do
    m = FactoryBot.create(:menu, name: "Jedyna w swoim rodzaju nazwa")
    n = m.name
    expect(Menu.where(:name => m.name).size).to eq(1)
    expect(Menu.where(:name => "Eeeee").size).to eq(0)
  end

  it "saves parent" do
    @parent = FactoryBot.create(:menu)
    @child = FactoryBot.create(:menu)
    @child.parent = @parent
    @child.save!
    expect(@parent.children.include?(@child))
  end

  it "validates presence of name" do
    @menu = Menu.new(:name => "", :id => -1)
    @menu.should_not be_valid
  end

  it "saves error for empty name" do
    @menu = Menu.new(:name => "", :id => -1)
    begin
      @menu.save!
    rescue
    end
    @menu.errors.should_not be_empty
  end

  it "new menu gets next available sequence number" do
    FactoryBot.create(:top_pl)
    @child_max = Menu.where(:ancestry => '1').maximum(:seq)
    menu = Menu.new(:name => "Parent", :lang_id => 1, :parent_id => 1)
    menu.save!
    menu.reload
    expect(menu.seq).to eq(@child_max + 1)
  end

   it "allows two menus with same name" do
    @menu = Menu.new(:name => "a", :lang_id => 1)
    @menu.save!
    @menu1 = Menu.new(:name => "a", :lang_id => 1)
    @menu1.save!
    expect(@menu.valid?)
    expect(@menu1.valid?)
  end


  it "has many contents" do
    @content = Content.create(:title => "Art")
    @menu = Menu.create(:name => "Child777", :parent_id => 1, :lang_id => 1)
    @menu.contents << @content
    @menu1 = Menu.find(@menu.id)
    @menu1.contents.size.should eq(1)
    @menu1.contents[0].title.should eq("Art")
  end

  describe 'has and belongs to many contents' do

    it 'reflect on association' do
      menu = Menu.reflect_on_association(:contents)
      menu.macro.should == :has_many
    end

    it 'properly saves contents for menu' do
      @content = FactoryBot.create(:content)
      @menu = FactoryBot.create(:menu)
      @menu.contents << @content
      @menu.reload
      @menu.contents.count.should eq(1)
      @content.menus.count.should eq(1)
    end
  end

  describe 'available_modules_by_pos' do
      before :each do
        @mod_pos = FactoryBot.create(:module_position)
        @stat_module = FactoryBot.create(:static_module)
        @stat_module.module_positions = [@mod_pos]
        @stat_module.save!
        @av_module = AvailableModule.where(static_module_id: @stat_module.id, module_position_id: @mod_pos.id).first
        @menu = FactoryBot.create(:menu)
      end

    it "available module is included" do
      expect(@menu.available_modules_by_pos[@mod_pos.id]).to eq([@av_module])
    end


    it "module selected in menu is not included" do
      @menu.available_modules << @av_module
      @menu.save!
      expect(@menu.available_modules_by_pos[@mod_pos.id].nil? || !@menu.available_modules_by_pos[@mod_pos.id].include?(@av_module)).to be_truthy
    end

    it "module selected in other menu is included" do
      @menu.available_modules << @av_module
      @menu.save!
      @menu1 = FactoryBot.create(:menu)
      expect(@menu1.available_modules_by_pos[@mod_pos.id].include?(@av_module)).to be_truthy
    end

    it "module 'always displayed' is not included" do
      @stat_module.always_displayed = true
      @stat_module.save!
      @av_modules = AvailableModule.where(:static_module_id => @stat_module.id)
      expect(@av_modules.length).to eq(1)
      expect((@menu.available_modules_by_pos[@mod_pos.id].nil?) || !@menu.available_modules_by_pos[@mod_pos.id].to_set.superset?(@av_modules.to_set)).to be_truthy
    end

    it "all availabale modules are served for new menu" do
      @new_menu = Menu.new
       expect((!@new_menu.available_modules_by_pos[@mod_pos.id].nil?) && !@new_menu.available_modules_by_pos[@mod_pos.id].empty?).to be_truthy
    end
  end

  describe 'selected_modules_by_pos' do
    it "module selected in menu is included" do
      mod_pos = FactoryBot.create(:module_position)
      stat_module = FactoryBot.create(:static_module)
      stat_module.module_positions = [mod_pos]
      stat_module.save!
      av_module = AvailableModule.where(static_module_id: stat_module.id, module_position_id: mod_pos.id).first
      menu = FactoryBot.create(:menu)
      menu.available_modules << av_module
      menu.save!
      expect(menu.selected_modules_by_pos[mod_pos.id].include?(av_module)).to be_truthy
    end

    it "module 'always displayed' is incuded" do
      mod_pos = FactoryBot.create(:module_position)
      stat_module = FactoryBot.create(:always_displayed_static_module)
      stat_module.module_positions = [mod_pos]
      stat_module.save!
      av_modules = AvailableModule.where(:static_module_id => stat_module.id)
      expect(av_modules.length).to eq(1)
      menu = FactoryBot.create(:menu)
      expect(!menu.selected_modules_by_pos[mod_pos.id].nil? && menu.selected_modules_by_pos[mod_pos.id].to_set.superset?(av_modules.to_set)).to be_truthy
    end
  end



  describe 'invisible_content' do
    it "true when any non-active content is assigned to menu - one element only" do
      @content = FactoryBot.create(:article_non_active)
      @menu = FactoryBot.create(:menu)
      @menu.contents << @content
      @menu.invisible_content.should be_truthy
    end

    it "true when any non-active content is assigned to menu - more that one element on the list element only" do
      @content = FactoryBot.create(:article_non_active)
      @content1 = FactoryBot.create(:article_displayed_and_active)
      @menu = FactoryBot.create(:menu)
      @menu.contents << @content
      @menu.invisible_content.should be_truthy
    end

    it "false for empty content list" do
      @menu = FactoryBot.create(:menu, :content_ids => nil)
      @menu.invisible_content.should be_falsey
    end

    it "true when any non-visible content is assigned to menu" do
      @content = FactoryBot.create(:article_non_displayed)
      @content1 = FactoryBot.create(:article_displayed_and_active)
      @menu = FactoryBot.create(:menu)
      @menu.contents << @content
      @menu.invisible_content.should be_truthy
    end

    it "false when no invisible content is present" do
      @content = FactoryBot.create(:article_displayed_and_active)
      @content1 = FactoryBot.create(:article_displayed_and_active)
      @menu = FactoryBot.create(:menu)
      @menu.contents << @content
      @menu.contents << @content1
      @menu.invisible_content.should be_falsey
    end
  end

  describe 'display_editable_field?' do

    it 'editable menu returns true for all fields' do
      @menu = FactoryBot.create(:menu)
      @menu.attributes.keys.each do |attribute|
        expect(@menu.display_editable_field?(attribute)).to be_truthy
      end
    end

    it 'not editable menu returns true for always_displayed fields and false otherwise' do
      @menu = FactoryBot.create(:menu, editable: false)
      @menu.attributes.keys.each do |attribute|
        expect(@menu.display_editable_field?(attribute)).to eq(@menu.always_editable_fields.include?(attribute))
      end
    end
  end

  describe 'some_editable' do
    it 'is invalid when not editable' do
      @menu = FactoryBot.create(:menu, :not_editable)
      @menu.name = 'aaa'
      # raise (@menu.valid?).inspect
      expect(@menu).not_to be_valid
    end

    it 'is valid when editable' do
      @menu = FactoryBot.create(:menu)
      @menu.name = 'aaa'
      expect(@menu).to be_valid
    end

    it 'is not valid when become editable' do
      @menu = FactoryBot.create(:menu, editable: false)
      @menu.name = 'aaa'
      expect(@menu).not_to be_valid
    end
  end

  describe 'lang' do

    before :each do
      @menu = Menu.new(name: "Tralalala")
      @pl = Menu.find_by(name: "pl")
      @content_pl = FactoryBot.create(:content, :pl)
      @content_en = FactoryBot.create(:content, :en)
      @content_all = FactoryBot.create(:content, :all_lang)
      @mod_pos = FactoryBot.create(:module_position)
      @stat_module = FactoryBot.create(:static_module, :pl)
      @stat_module.module_positions = [@mod_pos]
      @stat_module.save!
      @av_module_pl = AvailableModule.where(static_module_id: @stat_module.id, module_position_id: @mod_pos.id).first
      @stat_module_en = FactoryBot.create(:static_module, :en)
      @stat_module_en.module_positions = [@mod_pos]
      @stat_module_en.save!
      @av_module_en = AvailableModule.where(static_module_id: @stat_module_en.id, module_position_id: @mod_pos.id).first
      @stat_module_all = FactoryBot.create(:static_module, :all_lang)
      @stat_module_all.module_positions = [@mod_pos]
      @stat_module_all.save!
      @av_module_all = AvailableModule.where(static_module_id: @stat_module_all.id, module_position_id: @mod_pos.id).first
    end

    it 'is not selected then available parents, contents and static modules from default language' do
      expect(@menu.parent_tree.include?(@pl))
      expect(@menu.available_contents.include?(@content_pl)).to be_truthy
      expect(@menu.available_contents.include?(@content_en)).to be_falsey
      expect(@menu.available_contents.include?(@content_all)).to be_truthy
      expect(@menu.available_modules_by_pos[@mod_pos.id].include?(@av_module_pl)).to be_truthy
      expect(@menu.available_modules_by_pos[@mod_pos.id].include?(@av_module_en)).to be_falsey
      expect(@menu.available_modules_by_pos[@mod_pos.id].include?(@av_module_all)).to be_truthy
    end

    it 'pending is selected then available parents, contents and static modules from selected language' do
      FactoryBot.create(:lang_en)
      @root_en = Menu.find_by(name: "en")
      @menu1 = FactoryBot.create(:menu_en, id: 3)
      expect(@menu1.parent_tree.include?(@root_en))
      expect(@menu1.available_contents.include?(@content_en)).to be_truthy
      expect(@menu1.available_contents.include?(@content_pl)).to be_falsey
      expect(@menu1.available_contents.include?(@content_all)).to be_truthy
      expect(@menu1.available_modules_by_pos[@mod_pos.id].include?(@av_module_pl)).to be_falsey
      expect(@menu1.available_modules_by_pos[@mod_pos.id].include?(@av_module_en)).to be_truthy
      expect(@menu1.available_modules_by_pos[@mod_pos.id].include?(@av_module_all)).to be_truthy
    end

  end
end
end
