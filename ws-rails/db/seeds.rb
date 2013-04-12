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

userWangrui = User.create! :name => "kerry", :email => "rwang@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
userWangrui.confirm!
userQingshan = User.create! :name => "qingshan", :email => "qszhuan@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
userQingshan.confirm!
userYaoxin = User.create! :name => "xyao", :email => "xyao@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
userYaoxin.confirm!
zhuAo = User.create! :name => "azhu", :email => "azhu@thoughtworks.com", :password => "12345678".dup, :password_confirmation => "12345678".dup
zhuAo.confirm!