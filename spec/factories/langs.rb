# == Schema Information
#
# Table name: langs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  shortname  :string(255)
#  active     :boolean
#  menu_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :lang_en, :class => Mokio::Lang do
    id { 2 }
    name { 'en' }
    shortname { 'en' }
  end

  factory :lang_pl, :class => Mokio::Lang do
    id { 1 }
    name { 'pl' }
    shortname { 'pl' }
  end
end
