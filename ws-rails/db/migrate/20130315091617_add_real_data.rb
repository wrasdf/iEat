require 'oj'
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

  def prepareAllData
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
    migrate.prepareAllData
  end
end




