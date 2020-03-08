# frozen_string_literal: true

namespace :mokio do
  desc 'Creates custom.js file in project, for easy js alterations inside gem'
  task add_custom_js: :environment do
    puts 'Creating custom.js file...'.blue
    file = 'app/assets/javascripts/backend/custom.js'
    unless File.exist?(file)
      content = "// Add your js for backend here\n"
      touch file
      File.write(file, content)
      puts "Created new file at #{file}".green
    else
      puts 'File already exists'.red
    end
  end
end
