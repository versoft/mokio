namespace :mokio_install do
  desc 'Reset pg columns sequence'
  task reset_pg_sequence: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end