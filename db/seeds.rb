# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?

  require 'faker'
  TEMPLATE_IMAGE_PATH = Rails.root.join('db', 'images', 'placeholder.jpg')

  puts "purging db"
  Photo.delete_all

  100.times do |i|

    puts "Creating fake image ##{i}"
    # Generate a fake name using Faker
    name = Faker::Movie.title

    # Create a new Photo instance with the generated name
    time = Faker::Date.between(from: '2014-09-23', to: Date.today)

    photo = Photo.new(name: name, created_at: time)

    # Attach the template image
    photo.image.attach(io: File.open(TEMPLATE_IMAGE_PATH), filename: 'template_image.jpg', content_type: 'image/jpeg')

    # Save the Photo entry
    photo.save

    # This is needed because sqlite3 is so slow
    sleep(0.5)
  end
end