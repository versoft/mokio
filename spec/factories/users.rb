# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :user, :class => Mokio::User do
    email { 'testtesttest@test.test' }
    password { 'Passwor12d01!' }
    password_confirmation { 'Passwor12d01!' }
    roles_mask { Mokio::User.roles_mask_by_role(:super_admin) }
  end
end
