FactoryBot.define do
  factory :theme do
    header_color { '#1F2937' }
    logo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/logo.jpg'))) }
    avatar { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/avatar.jpg'))) }
    user_id { nil }

    after :create do |theme|
      theme.update_column(:logo, 'logo.png')
      theme.update_column(:avatar, 'avatar.png')
    end
  end
end
