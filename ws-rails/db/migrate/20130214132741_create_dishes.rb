class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.float :price
      t.text :description
      t.string :image_url
      t.references :restaurant

      t.timestamps
    end
    add_index :dishes, :restaurant_id
  end
end
