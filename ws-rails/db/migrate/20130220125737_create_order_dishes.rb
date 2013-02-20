class CreateOrderDishes < ActiveRecord::Migration
  def change
    create_table :order_dishes do |t|
      t.references :order
      t.references :dish
      t.integer :quantity

      t.timestamps
    end
    add_index :order_dishes, :order_id
    add_index :order_dishes, :dish_id
  end
end
