# == Schema Information
#
# Table name: selected_modules
#
#  id                  :integer          not null, primary key
#  available_module_id :integer
#  menu_id             :integer
#  seq                 :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

module Mokio

  describe SelectedModule do

    before(:each) do
      FactoryBot.create(:lang_pl)
      @menu = Mokio::Menu.first
      # raise @menu.inspect
      @position = FactoryBot.create(:module_position)
      @static_module = FactoryBot.create(:static_module, :module_position_ids => [@position.id])
    end

    it "adds properly new selected module to men" do
      av_mod = AvailableModule.first #?
      @menu.available_modules << av_mod
      @menu.save
      expect(SelectedModule.count).to eq(1)
      expect(@menu.available_modules.size).to eq(1)
    end

    it "removes properly selected module from menu" do
      av_mod = AvailableModule.first
      @menu.available_modules.delete(av_mod)
      @menu.save
      expect(SelectedModule.count).to eq(0)
      expect(@menu.available_modules.size).to eq(0)
    end


    it "counts only records that match a query" do
      FactoryBot.create(:menu, :name => "Uuups")
      expect(Menu.where(:name => "Uuups").size).to eq(1)
      expect(Menu.where(:name => "Eeeee").size).to eq(0)
    end

    it "saves parent" do
      @parent = FactoryBot.create(:menu, :name => "Parent")
      FactoryBot.create(:menu, :name => "Child", :parent => @parent)
      @parent = Menu.where(:name => "Parent").first
      @child = Menu.where(:name => "Child").first
      expect(@parent.children.include?(@child))
    end
    it "validates presence of name" do
      @menu = Menu.new(:name => "", :id => -1)
      @menu.should_not be_valid
    end

    it "saves error for empty name" do
      @menu = Menu.new(:name => "", :id => -1)
      begin
        @menu.save
      rescue
      end
      @menu.errors.should_not be_empty

    end

    it "has many contents" do
      @content = Content.create!(:title => "Art")
      @menu = Menu.create!(:name => "Child777", :parent_id => 1, :lang_id => 1)
      @menu.contents << @content
      @menu1 = Menu.find(@menu.id)
      @menu1.contents.size.should eq(1)
      @menu1.contents[0].title.should eq("Art")
    end

    # describe 'has and belongs to many contents' do

    #   it 'reflect on association' do
    #     menu = Menu.reflect_on_association(:contents)
    #     menu.macro.should == :has_many
    #   end

    #   it 'properly saves contents for menu' do
    #       @content = FactoryBot.create(:content)
    #       @menu = FactoryBot.create(:menu, :content_ids => [@content.id])
    #       @menu.reload
    #       @menu.contents.count.should eq(1)
    #       @content.menus.count.should eq(1)
    #   end
    # end
  end
end
