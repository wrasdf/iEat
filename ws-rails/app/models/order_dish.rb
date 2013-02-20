class OrderDish < ActiveRecord::Base
  belongs_to :order
  belongs_to :dish
  attr_accessible :quantity
end
