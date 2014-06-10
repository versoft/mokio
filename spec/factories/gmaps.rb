# == Schema Information
#
# Table name: gmaps
#
#  id                          :integer          not null, primary key
#  full_address                :string(255)
#  street_number               :string(255)
#  route                       :string(255)
#  locality                    :string(255)
#  postal_code                 :string(255)
#  country                     :string(255)
#  administrative_area_level_2 :string(255)
#  administrative_area_level_1 :string(255)
#  gtype                       :string(255)
#  lat                         :decimal(10, 6)
#  lng                         :decimal(10, 6)
#  zoom                        :integer          default(15)
#  created_at                  :datetime
#  updated_at                  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gmap do
    full_address "MyString"
    street_number "MyString"
    route "MyString"
    locality "MyString"
    postal_code "MyString"
    country "MyString"
    administrative_area_level_2 "MyString"
    administrative_area_level_1 "MyString"
    type ""
    lat "9.99"
    lng "9.99"
    zoom 1
  end
end
