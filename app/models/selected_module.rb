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

class SelectedModule < ActiveRecord::Base
  default_scope { order('seq') }
  belongs_to :menu
  belongs_to :available_module
  acts_as_list :column => :seq, :scope => :menu_id
end
