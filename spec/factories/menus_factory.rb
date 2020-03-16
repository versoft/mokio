require 'faker'

FactoryBot.define do

  factory :menu, :class=> Mokio::Menu do
    name { Faker::Lorem.word }
    lang_id { 1 }
    parent_id { 1 }
    seq { 1 }
    editable { true }

    factory :root_pl do
      id { 1 }
      name {"root pl-name"}
      lang_id { 1 }
      parent_id { nil }
    end

    factory :root_en do
      id { 2 }
      lang_id { 2 }
      parent_id { nil }
    end

    factory :top_pl do
      name {"top menu-name"}
      lang_id { 1 }
      parent_id { 1 }
    end

    factory :menu_without_lang do
      name { Faker::Lorem.word }
      seq { 1 }
      editable { true }
    end

    factory :menu_en, traits: [:en] do
      parent_id { 2 }
    end

  end

end
