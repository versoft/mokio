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

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :selected_module, :class => Mokio::SelectedModule do
  end
end
