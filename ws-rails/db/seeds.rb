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
restaurant2 = Restaurant.create! :id => 2, :name => "来福士", :telephone => "12312319283"
restaurant3 = Restaurant.create! :id => 3, :name => "桂林米粉", :telephone => "12312319283"

Dish.create! :restaurant => restaurant1, :price => 12.0, :name => "小炒肉"
Dish.create! :restaurant => restaurant1, :price => 12.0, :name => "土豆烧牛肉"
Dish.create! :restaurant => restaurant1, :price => 12.0, :name => "三杯鸡"
Dish.create! :restaurant => restaurant1, :price => 12.0, :name => "西红柿牛腩"

Dish.create! :restaurant => restaurant2, :price => 12.0, :name => "盒饭"
Dish.create! :restaurant => restaurant2, :price => 12.0, :name => "炒饼丝"
Dish.create! :restaurant => restaurant2, :price => 12.0, :name => "炒蒙面"
Dish.create! :restaurant => restaurant2, :price => 12.0, :name => "尖椒米饭"

Dish.create! :restaurant => restaurant3, :price => 12.0, :name => "普通米粉"
Dish.create! :restaurant => restaurant3, :price => 12.0, :name => "牛肉粉"
Dish.create! :restaurant => restaurant3, :price => 12.0, :name => "西瓜粉"
Dish.create! :restaurant => restaurant3, :price => 12.0, :name => "小炒粉丝"

Group.create! :id => 1, due_date:"2013-2-25 20:00", :user => userWangrui, :restaurant => restaurant1
Group.create! :id => 2, due_date:"2013-2-25 20:00", :user => userMingxin, :restaurant => restaurant2
Group.create! :id => 3, due_date:"2013-2-25 20:00", :user => userQingshan, :restaurant => restaurant3

