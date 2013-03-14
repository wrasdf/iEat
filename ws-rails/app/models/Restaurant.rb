class Restaurant < ActiveRecord::Base
  has_many :cuisines
  attr_accessible :name, :telephone, :address, :image_url, :note
end

