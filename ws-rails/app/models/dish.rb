class Dish < ActiveRecord::Base
  belongs_to :restaurant
  attr_accessible :description, :image_url, :name, :price, :restaurant_id
end
