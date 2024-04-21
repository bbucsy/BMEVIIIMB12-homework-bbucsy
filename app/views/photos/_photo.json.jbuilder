json.extract! photo, :id, :name, :image, :created_at, :updated_at
json.image url_for(photo.image)
