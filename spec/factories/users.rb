# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'testtesttest@test.test'
    password 'password'
    password_confirmation 'password'
    roles_mask 1
  end
end
