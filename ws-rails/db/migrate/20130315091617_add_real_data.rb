require 'oj'

class Restaurant < ActiveRecord::Base
  has_many :cuisines
  attr_accessible :name, :telephone, :address, :image_url, :note
end

class Cuisine < ActiveRecord::Base
  belongs_to :restaurant
  has_many :dishes
  attr_accessible :id, :name, :restaurant
end

class Dish < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :cuisine
  attr_accessible :id, :description, :image_url, :name, :price, :restaurant, :cuisine
end

class MigrateScript

  def initialize
    @data = get_file_as_string("#{File.expand_path(File.dirname(__FILE__))}/../resources/restaurants.json")
  end

  def get_file_as_string(filename)
    data = ''
    f = File.open(filename, "r")
    f.each_line do |line|
      data += line
    end
    data
  end

  def prepare_all_data
    all = Oj.load(@data)
    all.each do |restaurant|
      @restaurant = Restaurant.create! :name => restaurant['name'], :telephone => restaurant['telephone'], :address => restaurant['address'], :note=> restaurant['note']
      restaurant['cuisine'].each do |cuisine|
        @cuisine = Cuisine.create! :name => cuisine['type'], :restaurant => @restaurant
        cuisine['dishes'].each do |dish|
          Dish.create! :cuisine=>@cuisine, :restaurant => @restaurant, :price => dish['price'], :name => dish['name']
        end
      end
    end
  end

end

class AddRealData < ActiveRecord::Migration
  def change
    migrate = MigrateScript.new()
    migrate.prepare_all_data
  end
end




