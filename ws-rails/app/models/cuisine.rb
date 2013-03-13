class Cuisine < ActiveRecord::Base
  belongs_to :restaurant
  has_many :restaurant_cuisines
  has_many :dishes
  attr_accessible :id, :name, :dish_id
end
