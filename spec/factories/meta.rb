# == Schema Information
#
# Table name: meta
#
#  id                 :integer          not null, primary key
#  g_title            :string(255)
#  g_desc             :string(255)
#  g_keywords         :string(255)
#  g_author           :string(255)
#  g_copyright        :string(255)
#  g_application_name :string(255)
#  f_title            :string(255)
#  f_type             :string(255)
#  f_image            :string(255)
#  f_url              :string(255)
#  f_desc             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :metum, :class => 'Meta' do
    g_title ""
    g_desc "MyString"
    g_keywords "MyString"
    g_author "MyString"
    g_copyright "MyString"
    g_application_name "MyString"
    f_title "MyString"
    f_type "MyString"
    f_image "MyString"
    f_url "MyString"
    f_desc "MyString"
  end
end
