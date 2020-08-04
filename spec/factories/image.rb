FactoryBot.define do
  factory :image do
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/bautroi2.jpg')))}
    room {FactoryBot.create :room}
    after :create do |b|
      b.update_column(:image, "bautroi2.jpg")
    end
  end
end
