class AddPaidAttributeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paid, :boolean
  end
end
