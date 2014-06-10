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

describe SelectedModule do

   before(:each) do
    @menu = FactoryGirl.create(:menu)
    @position = FactoryGirl.create(:module_position)
    @static_module = FactoryGirl.create(:static_module, :module_position_ids => [@position.id])
  end

  it "adds properly new selected module to men" do
    av_mod = AvailableModule.first #?
    @menu.available_modules << av_mod
    @menu.save
    expect(SelectedModule).to have(1).records
    expect(@menu.available_modules.size).to eq(1)
  end

  it "removes properly selected module from menu" do
    av_mod = AvailableModule.first
    @menu.available_modules.delete(av_mod)
    @menu.save
    expect(SelectedModule).to have(0).records
    expect(@menu.available_modules.size).to eq(0)
  end

 
  # it "counts only records that match a query" do
  #   Menu.create!(:name => "Uuups")
  #   expect(Menu.where(:name => "Uuups")).to have(1).record
  #   expect(Menu.where(:name => "Eeeee")).to have(0).records
  # end

  # it "saves parent" do
  #   @parent = Menu.create!(:name => "Parent")
  #   Menu.create!(:name => "Child", :parent => Menu.create!(:name => "Parent"))
  #   @parent = Menu.where(:name => "Parent").first
  #   @child = Menu.where(:name => "Child").first
  #   expect(@parent.children.include?(@child))
  # end
  # it "validates presence of name" do
  #   @menu = Menu.new(:name => "", :id => -1)
  #   @menu.should_not be_valid
  # end

  # it "saves error for empty name" do
  #   @menu = Menu.new(:name => "", :id => -1)
  #   begin
  #     @menu.save
  #   rescue
  #   end
  #   @menu.errors.should_not be_empty
   
  # end

  # it "validates if lang matches parent" do
  #   @parent = Menu.new(:name => "Parent", :lang_id => 1)
  #   @parent.save
  #   @menu = Menu.new(:name => "Child", :parent_id => @parent.id, :lang_id => 2)
  #   @menu.should_not be_valid
  # end

  # it "saves error for not matching parent and lang" do
  #   @parent = Menu.new(:name => "Parent", :lang_id => 1)
  #   @parent.save
  #   @menu = Menu.new(:name => "Child", :parent_id => @parent.id, :lang_id => 2)
  #   begin
  #     @menu.save
  #   rescue
  #   end
  #   @menu.errors.should_not be_empty
    
  # end

  # it "has many contents" do
  #   @menu = Menu.new(:name => "Child777", :parent_id => 1, :lang_id => 1)
  #   @content = Content.new(:title => "Art")
  #   @content.save
  #   @menu.contents << @content
  #   @menu.save
  #   @menu1 = Menu.find(@menu.id)
  #   @menu1.contents.size.should eq(1)
  #   @menu1.contents[0].title.should eq("Art")
  # end

  # describe 'has and belongs to many contents' do
    
  #   it 'reflect on association' do
  #     menu = Menu.reflect_on_association(:contents)
  #     menu.macro.should == :has_many
  #   end

  #   it 'properly saves contents for menu' do
  #       @content = FactoryGirl.create(:content)
  #       @menu = FactoryGirl.create(:menu, :content_ids => [@content.id])
  #       @menu.reload
  #       @menu.contents.count.should eq(1)
  #       @content.menus.count.should eq(1)
  #   end
  # end
end
