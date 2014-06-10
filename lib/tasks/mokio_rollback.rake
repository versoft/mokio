require 'rake'

namespace :mokio do
  desc "Rollbacks rake mokio:install"

  task :rollback do
    Thread.new do
      %x{ rails d mokio:install }
    end

    Rake::Task["db:rollback"].execute
  end
end