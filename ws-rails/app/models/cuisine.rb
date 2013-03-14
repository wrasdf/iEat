class Cuisine < ActiveRecord::Base
  belongs_to :restaurant
  has_many :dishes
  attr_accessible :id, :name, :restaurant
end
