require 'faker'

FactoryGirl.define do

  factory :static_module, traits: [:with_intro_and_content], :class => Mokio::StaticModule do
    title Faker::Lorem.word
    display_from '2013-12-02'
    display_to '2013-12-31'
    lang_id 1
    always_displayed false

    factory :static_module_without_title do
      title ''
    end

    factory :always_displayed_static_module do
      always_displayed true
    end

    factory :with_module_position do
      module_position_ids ['1']
    end
  end

  factory :module_position, :class => Mokio::ModulePosition do
    name Faker::Lorem.word
  end
end