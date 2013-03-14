# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.confirm!
user.add_role :admin

userWangrui = User.create! :name => "王锐", :email => "rwang@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
userWangrui.confirm!
userMingxin = User.create! :name => "明星", :email => "mxzou@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
userMingxin.confirm!
userQingshan = User.create! :name => "青山", :email => "qszhuan@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
userQingshan.confirm!
userXiaochong = User.create! :name => "小虫", :email => "xczhang@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
userXiaochong.confirm!

restaurant1 = Restaurant.create! :id => 1, :name => "九头鹰", :telephone => "12312319283"
restaurant2 = Restaurant.create! :id => 2, :name => "来福士超市", :telephone => "12312319283"
restaurant3 = Restaurant.create! :id => 3, :name => "桂林米粉", :telephone => "12312319283"
restaurant4 = Restaurant.create! :id => 4, :name => "来福士热烫皮", :telephone => "12312319283"
restaurant5 = Restaurant.create! :id => 5, :name => "Subway", :telephone => "12312319283"

cuisine1 = Cuisine.create! :id => 1, :name => "炒菜", :restaurant => restaurant1
cuisine2 = Cuisine.create! :id => 2, :name => "主食", :restaurant => restaurant1
cuisine3 = Cuisine.create! :id => 3, :name => "主食", :restaurant => restaurant2
cuisine4 = Cuisine.create! :id => 4, :name => "米粉", :restaurant => restaurant3
cuisine5 = Cuisine.create! :id => 5, :name => "主食", :restaurant => restaurant4
cuisine6 = Cuisine.create! :id => 6, :name => "主食", :restaurant => restaurant5

Dish.create! :id=>1, :cuisine=>cuisine1, :restaurant => restaurant1, :price => 15.0, :name => "小炒肉"
Dish.create! :id=>2, :cuisine=>cuisine1, :restaurant => restaurant1, :price => 18.0, :name => "土豆烧牛肉"
Dish.create! :id=>3, :cuisine=>cuisine1, :restaurant => restaurant1, :price => 14.0, :name => "三杯鸡"
Dish.create! :id=>4, :cuisine=>cuisine1, :restaurant => restaurant1, :price => 15.0, :name => "西红柿牛腩"
Dish.create! :id=>5, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 5.0, :name => "热干面"
Dish.create! :id=>6, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 12.0, :name => "鸡蛋炒面"
Dish.create! :id=>7, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 12.0, :name => "鸡丝面"
Dish.create! :id=>8, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 12.0, :name => "红烧牛肉面"
Dish.create! :id=>9, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 12.0, :name => "鸡蛋炒大米"
Dish.create! :id=>10, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 1.0, :name => "米饭"

Dish.create! :id=>11, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 12.0, :name => "盒饭"
Dish.create! :id=>12, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 12.0, :name => "炒饼丝"
Dish.create! :id=>13, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 12.0, :name => "炒蒙面"
Dish.create! :id=>14, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 12.0, :name => "尖椒米饭"
Dish.create! :id=>23, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 12.0, :name => "热炒饭"
Dish.create! :id=>24, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 16.0, :name => "1荤1素盒饭"
Dish.create! :id=>25, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 6.0, :name => "肉夹馍"
Dish.create! :id=>26, :cuisine=>cuisine3, :restaurant => restaurant2, :price => 4.0, :name => "土豆丝饼"

Dish.create! :id=>15, :cuisine=>cuisine4, :restaurant => restaurant3, :price => 12.0, :name => "普通米粉"
Dish.create! :id=>16, :cuisine=>cuisine4, :restaurant => restaurant3, :price => 12.0, :name => "牛肉粉"
Dish.create! :id=>17, :cuisine=>cuisine4, :restaurant => restaurant3, :price => 12.0, :name => "西瓜粉"
Dish.create! :id=>18, :cuisine=>cuisine4, :restaurant => restaurant3, :price => 12.0, :name => "小炒粉丝"

Dish.create! :id=>19, :cuisine=>cuisine5, :restaurant => restaurant4, :price => 10.0, :name => "热烫皮"
Dish.create! :id=>20, :cuisine=>cuisine5, :restaurant => restaurant4, :price => 7.0, :name => "肉夹馍"
Dish.create! :id=>21, :cuisine=>cuisine5, :restaurant => restaurant4, :price => 7.0, :name => "凉皮"
Dish.create! :id=>22, :cuisine=>cuisine5, :restaurant => restaurant4, :price => 7.0, :name => "凉面"

Dish.create! :id=>27, :cuisine=>cuisine6, :restaurant => restaurant5, :price => 15.0, :name => "特惠套餐"

#Group.create! :id => 1, :name => "辣团", due_date:"2013-3-25 20:00", :user => userWangrui, :restaurant => restaurant1
#Group.create! :id => 2, :name => "疯团", due_date:"2013-3-25 20:00", :user => userMingxin, :restaurant => restaurant2
#Group.create! :id => 3, :name => "奇异团", due_date:"2013-3-25 20:00", :user => userQingshan, :restaurant => restaurant3
#Group.create! :id => 4, :name => "辣团", due_date:"2013-2-25 20:00", :user => userWangrui, :restaurant => restaurant1