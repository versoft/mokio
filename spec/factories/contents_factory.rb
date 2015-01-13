require 'faker'

FactoryGirl.define do

  factory :content, traits: [:with_intro_and_content], :class=> Mokio::Content do
    title Faker::Lorem.word
    display_from '2013-12-02'
    display_to '2013-12-31'
   
    trait :home_page do
      home_page true
    end

    trait :id1 do
      id 1
    end

    trait :id2 do
      id 2
    end

    factory :content_id1, traits: [:id1]
    factory :content_id2, traits: [:id2]

    factory :home_page_content, traits: [:home_page]
    factory :not_editable_content, traits: [:not_editable]
    factory :not_deletable_content, traits: [:not_deletable]
    factory :created_by_admin_content, traits: [:not_editable, :not_deletable]

    factory :first_content do
      
    end

    factory :content_without_title do
      title ''
    end

    factory :content_with_main_pic do
      main_pic "#{Faker::Lorem.word}.png"
    end

    factory :content_with_data_file_blank do
      main_pic nil
    end

    factory :content_display_to_from_nil do
      display_from nil
      display_to nil
    end
    
    factory :content_display_to_nil_displayed do
      display_from '2011-12-12'
      display_to nil
    end


    factory :content_display_from_nil_displayed do
      display_from nil
      display_to '2123-12-12'
    end
    
    factory :content_not_displayed do
      display_from '2011-12-12'
      display_to '2011-12-25'
    end


    factory :content_display_to_nil_not_displayed do
      display_from '2123-12-12'
      display_to nil
    end


    factory :content_display_from_nil_not_displayed do
      display_from nil
      display_to '2012-12-12'
    end

    factory :article do
      type 'Mokio::Article'
    end

    factory :article_non_active do
      type 'Mokio::Article'
      active false
    end

    factory :article_non_displayed do
      type 'Mokio::Article'
      display_from '2011-12-12'
      display_to '2011-12-25'
    end


    factory :article_displayed_and_active do
      type 'Mokio::Article'
      display_from nil
      display_to nil
      active true
    end

    factory :pic_gallery do
      type 'Mokio::PicGallery'
      gallery_type 'pic'

      factory :home_page_pic_gallery, traits: [:home_page]
      factory :not_editable_pic_gallery, traits: [:not_editable]
      factory :not_deletable_pic_gallery, traits: [:not_deletable]
    end

    factory :mov_gallery do
      type 'Mokio::MovGallery'
      gallery_type 'mov'

      factory :home_page_mov_gallery, traits: [:home_page]
      factory :not_editable_mov_gallery, traits: [:not_editable]
      factory :not_deletable_mov_gallery, traits: [:not_deletable]
    end

    factory :contact do
      contact true
      type 'Mokio::Contact'

      factory :not_editable_contact, traits: [:not_editable]
      factory :not_deletable_contact, traits: [:not_deletable]
    end
  end
end