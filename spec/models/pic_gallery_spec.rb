# == Schema Information
#
# Table name: contents
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  intro        :text
#  content      :text
#  type         :string(255)
#  home_page    :boolean
#  tpl          :string(255)
#  contact      :boolean
#  active       :boolean          default(TRUE)
#  lang_id      :integer
#  gallery_type :string(255)
#  editable     :boolean          default(TRUE)
#  deletable    :boolean          default(TRUE)
#  display_from :date
#  display_to   :date
#  created_at   :datetime
#  updated_at   :datetime
#  meta_id      :integer
#  gmap_id      :integer
#

require 'spec_helper'

module Mokio

  describe PicGallery do

    describe 'defaults' do
      before(:each) do
        @gallery = PicGallery.new
      end

      it 'has PicGallery type' do
        @gallery.type.should == "Mokio::PicGallery"
      end

      it 'is invalid without title' do
        @gallery.should_not be_valid
      end

      #
      # default added PicGallery have to have this values
      #
      it 'is editable' do
        @gallery.editable.should == true
      end

      it 'is deletable' do
        @gallery.deletable.should == true
      end

      it 'is active' do
        @gallery.active.should == true
      end
    end

    describe 'associations and inheritance' do
      #
      # PicGallery < Content
      #
      it 'is Content child' do
        expect(subject).to be_a_kind_of Content
      end

      it "should have many data_files" do
        association = PicGallery.reflect_on_association(:data_files)
        association.macro.should == :has_many
      end

      it "should have many menus" do
        association = PicGallery.reflect_on_association(:menus)
        association.macro.should == :has_many
      end

      it "should have many content_links" do
        association = PicGallery.reflect_on_association(:content_links)
        association.macro.should == :has_many
      end
    end

    it 'has default_data_file saved as model reference' do
      gallery = PicGallery.new
      gallery.default_data_file.should_not == "Photo"
      gallery.default_data_file.should == Photo
    end

    describe 'data_files' do
      it 'saves association with data_file' do
        gallery = PicGallery.new(:title => "test")
        gallery.data_files.build(data_file: "test.png", name: "Test")
        gallery.save!
        expect(DataFile).to have(1).records
      end

      it 'does not save association without data_file' do
        content = PicGallery.new(:title => "test")
        content.save!
        expect(DataFile).to have(0).records
      end
    end
  end
end