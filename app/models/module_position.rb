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

class ModulePosition < ActiveRecord::Base
  has_and_belongs_to_many :static_modules, :join_table => "available_modules"

  accepts_nested_attributes_for :static_modules

  amoeba do
    enable
  end
end
