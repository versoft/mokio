# == Schema Information
#
# Table name: recipients
#
#  id         :integer          not null, primary key
#  email      :string(255)      not null
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  contact_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipient, :class => Mokio::Recipient do
    email "MyString"
    active false
    contact_id 1
  end
end
