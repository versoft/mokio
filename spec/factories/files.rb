FactoryBot.define do
  factory :sample_image do
    data_file { Rack::Test::UploadedFile.new(File.open(File.expand_path('../../fixtures/files/sample_image.jpg', __FILE__))) }
  end
end
