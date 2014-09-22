require 'rake'
require 'bcrypt'
namespace :mokio do
  desc "Creates specified user"

  task :create_user, [:email, :password] => :environment do |t, args|
    args.with_defaults(:email => "admin@admin.com", :password => "blabla")
    @user = Mokio::User.new(:email => args[:email], :password => args[:password], :roles_mask => 1)

    if @user.save(validate: false)
      puts "User: #{args[:email]} with password: #{args[:password]} sucessfully created."
    else
      puts "Nie udało się utworzyć użytkownika"
    end
  end
end