# == Schema Information
#
# Table name: contact_templates
#
#  id         :integer          not null, primary key
#  tpl        :text
#  created_at :datetime
#  updated_at :datetime
#  contact_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_template do
    tpl "MyText"
  end
end
