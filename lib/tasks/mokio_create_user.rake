require 'rake'
require 'bcrypt'
namespace :mokio do
  desc "Creates specified user"

  task :create_user, [:email, :password] => :environment do |t, args|
    args.with_defaults(:email => "admin@admin.com", :password => "admin")
    @user = Mokio::User.new(:email => args[:email], :password => args[:password], :roles_mask => 1)

    if @user.save(validate: false)
      puts "User: #{args[:email]} with password: #{args[:password]} sucessfully created."
    else
      puts "Nie udało się utworzyć użytkownika"
    end
  end

  task :change_user_to_super_admin, [:email] => :environment do |t, args|
    email = args[:email]
    raise "No email!" if email.blank?

    @user = Mokio::User.find_by(email: email)
    raise "User not find by this email!" unless @user

    amount_super_admins = Mokio::User.where(roles_mask: Mokio::User.roles_mask_by_role(:super_admin)).size
    raise "Already exists Super admin" if amount_super_admins > 0

    @user.roles = [:super_admin]
    if @user.save(validate: false)
      puts "User #{email} has been changed to super admin!"
    else
      puts "Failed during save!"
    end
  end
end
