class RemoveColumnNameFromGroup < ActiveRecord::Migration
  def change
    remove_column :groups, :name
  end
end
