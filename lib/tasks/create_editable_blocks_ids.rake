namespace :mokio do
  desc 'Create hashes for editable blocks'

  task editable_blocks_ids: :environment do |t, args|
    20.times do
      puts SecureRandom.hex(8)
    end
  end

end
