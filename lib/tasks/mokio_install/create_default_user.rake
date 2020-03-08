namespace :mokio_install do
  desc 'Create default Mokio::User'
  task :create_default_user, %i[email password] => :environment do |_t, args|
    default_user = Mokio::User.where(email: args[:email])&.first
    unless default_user.present?
      user = Mokio::User.new({
                              email: args[:email],
                              password: args[:password],
                              password_confirmation: args[:password],
                              roles: [:super_admin]
                            })
      if user.save(validate: false)
        puts "Created default user '#{args[:email]}' with password '#{args[:password]}'".green
      end
    else
      puts "Mokio::User '#{default_user.email}' already exist".brown
    end
  end
end