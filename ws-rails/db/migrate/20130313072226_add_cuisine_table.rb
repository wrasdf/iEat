class AddCuisineTable < ActiveRecord::Migration
  def change
    create_table :cuisines do |t|
      t.references :restaurant
      t.string  :name
    end
    add_index :restaurants, :id

    add_column :dishes, :cuisine_id, :integer
  end
end
