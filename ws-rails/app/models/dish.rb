class Dish < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :cuisine
  attr_accessible :id, :description, :image_url, :name, :price, :restaurant, :cuisine
end
