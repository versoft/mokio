namespace :mokio do
  desc 'Create hashes for editable blocks'

  task editable_blocks_ids: :environment do |t, args|
    40.times do
      puts SecureRandom.hex(12)
    end
  end

end
