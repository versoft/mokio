# == Schema Information
#
# Table name: static_modules
#
#  id                   :integer          not null, primary key
#  available_modules_id :integer
#  title                :string(255)
#  content              :text
#  external_link        :string(255)
#  lang_id              :integer
#  active               :boolean          default(TRUE)
#  editable             :boolean          default(TRUE)
#  deletable            :boolean          default(TRUE)
#  always_displayed     :boolean
#  tpl                  :string(255)
#  display_from         :datetime
#  display_to           :datetime
#  created_at           :datetime
#  updated_at           :datetime
#  intro                :text
#

require 'spec_helper'

module Mokio

  describe StaticModule do

    before(:all) do
      StaticModule.delete_all
      SelectedModule.delete_all
      AvailableModule.delete_all
    end

    it 'has valid factory' do
      FactoryBot.create(:static_module).should be_valid
    end

    it 'is invalid without title' do
      FactoryBot.build(:static_module_without_title).should_not be_valid
    end

    describe 'default values' do
      before(:each) do
        @static_module = FactoryBot.build(:static_module)
      end

      it 'is editable' do
        @static_module.editable.should == true
      end

      it 'is deletable' do
        @static_module.deletable.should == true
      end

      it 'is active' do
        @static_module.active.should == true
      end
    end

    describe 'has and belongs to many module positions' do
      it 'reflect on association' do
        static_module = StaticModule.reflect_on_association(:module_positions)
        static_module.macro.should == :has_and_belongs_to_many
      end

      describe 'without module position in database' do
        it 'is invalid' do
          expect { FactoryBot.create(:with_module_position).data_files }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      it 'does not save through available_modules without module position' do
        static_module = FactoryBot.create(:static_module)
        static_module.save!
        expect(AvailableModule.count).to eq(0)
      end

      describe 'with module position in database' do
        before(:each) do
          position = FactoryBot.create(:module_position)
          @static_module = FactoryBot.create(:static_module, :module_position_ids => [position.id])
        end

        it 'is valid' do
          @static_module.should be_valid
        end

        it 'saves through available_modules' do
          @static_module.save!
          expect(AvailableModule.count).to eq(1)
        end
      end
    end

    describe 'functions' do
      context 'columns for table' do
        it 'returns array of values' do
          expect(StaticModule.columns_for_table).to eq(["title", "active", "module_position_ids", "updated_at", "lang_id"])
        end
      end
    end
  end
end
