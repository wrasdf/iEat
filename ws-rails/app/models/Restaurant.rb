class Restaurant < ActiveRecord::Base
  attr_accessible :name, :telephone, :address, :image_url
  has_many :restaurant_cuisines
end

