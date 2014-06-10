require 'faker'

FactoryGirl.define do
  trait :not_editable do
    editable false
    deletable false
  end

  trait :not_deletable do
    deletable false
  end

  trait :with_intro_and_content do
    intro Faker::Lorem.paragraph(3)
    content Faker::Lorem.paragraph(20)
  end

  trait :pl do
    lang_id 1
  end

  trait :en do
    lang_id 2
  end

  trait :all_lang do
    lang_id nil
  end

end