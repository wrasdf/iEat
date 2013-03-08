class OrderDish < ActiveRecord::Base
  belongs_to :order
  belongs_to :dish
  attr_accessible :order, :dish_id, :quantity
end
