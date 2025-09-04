class CreateClothingItems < ActiveRecord::Migration[8.0]
  def change
    create_table :clothing_items do |t|
      t.integer :user_id
      t.string :category
      t.string :color_primary_name
      t.string :color_secondary_name
      t.string :color_primary_hex
      t.string :color_secondary_hex
      t.text :notes
      t.string :image_url
      t.integer :hue
      t.integer :saturation
      t.integer :lightness

      t.timestamps
    end
  end
end
