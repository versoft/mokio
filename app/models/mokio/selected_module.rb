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
module Mokio
  class SelectedModule < ActiveRecord::Base
    include Mokio::Concerns::Models::SelectedModule
  end
end