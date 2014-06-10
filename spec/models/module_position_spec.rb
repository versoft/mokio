# == Schema Information
#
# Table name: module_positions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  tpl        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe ModulePosition do
  it 'has valid factory' do
    FactoryGirl.create(:module_position).should be_valid
  end

  describe 'has and belongs to many static modules' do
    it 'reflect on association' do
      module_position = ModulePosition.reflect_on_association(:static_modules)
      module_position.macro.should == :has_and_belongs_to_many
    end
  end
end
