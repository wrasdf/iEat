class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.references :user
      t.datetime :due_date
      t.references :restaurant

      t.timestamps
    end
    add_index :groups, :user_id
    add_index :groups, :restaurant_id
  end
end
