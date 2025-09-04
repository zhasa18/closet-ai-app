# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


ClothingItem.delete_all
ClothingItem.create!(
  [
    { category: "tshirt", color_primary_name: "blue", color_primary_hex: "#2d6cdf", notes: "crew", image_url: "https://picsum.photos/seed/tee/400" },
    { category: "pants",  color_primary_name: "khaki", color_primary_hex: "#c3b091", notes: "chinos", image_url: "https://picsum.photos/seed/pants/400" }
  ]
)
puts "Seeded #{ClothingItem.count} items."
