# == Schema Information
#
# Table name: available_modules
#
#  id                 :integer          not null, primary key
#  created_at         :datetime
#  updated_at         :datetime
#  module_position_id :integer
#  static_module_id   :integer
#

require 'spec_helper'

module Mokio

  describe AvailableModule do

    before(:each) do
      @menu = FactoryGirl.create(:menu)
      @position = FactoryGirl.create(:module_position)
      @static_module = FactoryGirl.create(:static_module, :module_position_ids => [@position.id])
    end

    it "module_title returns title of related static module" do
      av_mod = AvailableModule.where(static_module_id: @static_module.id, module_position_id: @position.id).first
      expect(av_mod.module_title).to eq(@static_module.title)
    end
  end
end