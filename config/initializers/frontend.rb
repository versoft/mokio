Rails.application.configure do |conf|
  conf.default_url_options = {host: ENV['APP_HOST'] || "localhost:3000"}
end
