class AddCuisineTable < ActiveRecord::Migration
  def change
    create_table :cuisines do |t|
      t.string  :name
    end

    create_table :restaurant_cuisines do |t|
      t.references :restaurant
      t.references :cuisine
    end

    add_index :restaurant_cuisines, :restaurant_id
    add_index :restaurant_cuisines, :cuisine_id

    add_column :dishes, :cuisine_id, :integer
  end
end
