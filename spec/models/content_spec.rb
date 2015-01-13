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
  describe Content do

    it "has a valid factory" do
      FactoryGirl.create(:content).should be_valid
    end

    it 'is invalid without title' do
      FactoryGirl.build(:content_without_title).should_not be_valid
    end

    it "should have many data_files" do
      content = Content.reflect_on_association(:data_files)
      content.macro.should == :has_many

      expect { FactoryGirl.create(:content).data_files }.to_not raise_error
    end

    describe 'defalut value' do
      before(:each) do
        @content = FactoryGirl.build(:content)
      end

      it 'is editable' do
        @content.editable.should == true
      end

      it 'is deletable' do
        @content.deletable.should == true
      end

      it 'is active' do
        @content.active.should == true
      end
    end

    describe "simple content" do
      it 'has content_type = nil' do
        FactoryGirl.build(:content).type.should be_nil
      end

      context "with main pic" do
        it 'is valid' do
          FactoryGirl.create(:content_with_main_pic).should be_valid
        end

        it 'saves association with data_file' do
          content = FactoryGirl.create(:content_with_main_pic)
          content.save!
          # content.main_pic.should_not be_blank
          pending "Main pic is not saved using FactoryGirl"
        end

      end
    end

    describe 'functions' do

      context 'columns for table' do
        it 'returns array of values' do
          expect(Content.columns_for_table).to eq(["title", "active", "type", "updated_at", "lang_id"])
        end
      end

      context 'displayed' do
        it 'is true for nil display_from and display_to' do
          content =  FactoryGirl.create(:content_display_to_from_nil)
          expect(content.displayed?).to be_true
        end

        it 'is true for display_from in the past and nil display_to' do
          content =  FactoryGirl.create(:content_display_to_nil_displayed)
          expect(content.displayed?).to be_true
        end

        it 'is true for nil display_from and display_to in the future' do
          content =  FactoryGirl.create(:content_display_from_nil_displayed)
          expect(content.displayed?).to be_true
        end

        it 'is false for display_from and display_to out of range' do
          content =  FactoryGirl.create(:content_not_displayed)
          expect(content.displayed?).to be_false
        end

        it 'is false for display_from in the future and nil display_to' do
          content =  FactoryGirl.create(:content_display_to_nil_not_displayed)
          expect(content.displayed?).to be_false
        end

        it 'is false for nil display_from and display_to in the past' do
          content =  FactoryGirl.create(:content_display_from_nil_not_displayed)
          expect(content.displayed?).to be_false
        end
      end
    end
  end
end