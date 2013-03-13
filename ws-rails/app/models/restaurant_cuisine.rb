class RestaurantCuisine < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :cuisine
  attr_accessible :restaurant, :cuisine_id, :restaurant_id, :cuisine
end
