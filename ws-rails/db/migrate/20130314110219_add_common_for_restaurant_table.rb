class AddCommonForRestaurantTable < ActiveRecord::Migration
  def change
    add_column :restaurants, :note, :string
  end
end
