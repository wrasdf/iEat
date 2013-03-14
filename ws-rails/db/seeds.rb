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

restaurant1 = Restaurant.create! :id => 1, :name => "九头鹰", :telephone => "84073084", :address => "东直门内大街10号楼7号", :note=> "湖北菜"
restaurant2 = Restaurant.create! :id => 2, :name => "来福士超市", :telephone => "No mobile phone", :address=>"来福士"
restaurant3 = Restaurant.create! :id => 3, :name => "李记桂林米粉", :telephone => "84033884/13161311387", :address => "东直门簋街5-3号哈哈镜对面"
restaurant4 = Restaurant.create! :id => 4, :name => "来福士热烫皮", :telephone => "No mobile phone", :address=>"来福士"
restaurant5 = Restaurant.create! :id => 5, :name => "Subway", :telephone => "No mobile phone", :address=>"来福士"
restaurant6 = Restaurant.create! :id => 6, :name => "咱家饺子", :telephone => "84045153", :address=>"东直门南小街55号" , :note => "订餐时间：11:30之前，12:30之后，50元起"
restaurant7 = Restaurant.create! :id => 7, :name => "李先生牛肉面", :telephone => "64610448", :address=>"东直门机场快轨入口附近"
restaurant8 = Restaurant.create! :id => 8, :name => "味道.台", :telephone => "15910735750", :address=>"来福士", :note => "50元以上，两公里以内送餐"
restaurant9 = Restaurant.create! :id => 9, :name => "必胜宅急送", :telephone => "4008 123 123", :address=>"www.必胜宅急送.com"
restaurant10 = Restaurant.create! :id => 10, :name => "粤之味", :telephone => "13717533289", :address=>"来福士购物中心B1"
restaurant11 = Restaurant.create! :id => 11, :name => "正午紫菜包饭", :telephone => "81808775/13552778775", :address=>"东直门外新中街七号", :note => "营业时间8:30-21:00"
restaurant12 = Restaurant.create! :id => 12, :name => "萨莉亚", :telephone => "84549645", :address=>"东直门外大街48号东方银座写字楼C层", :note => "分量较小~ 起送金额：60元以上；送餐时间：11:00之前"
restaurant13 = Restaurant.create! :id => 13, :name => "和合谷", :telephone => "6461 6113", :address=>"东直门交通枢纽店", :note=>"外卖费5块"
restaurant14 = Restaurant.create! :id => 14, :name => "吉野家东直门店", :telephone => "84477891", :address=>"东直门外48号银座MALL B1 07商铺(银座MALL地下一层",:note=>"点多少都收7元送餐费"
restaurant15 = Restaurant.create! :id => 15, :name => "粥面故事", :telephone => "4000365777", :address=>"www.chinanzbm.com", :note => "100元以上免费送餐"
restaurant16 = Restaurant.create! :id => 16, :name => "沙嗲诱惑", :telephone => "13811624091 / 13521886500", :address=>"东直门来福士广场B1", :note => "50元免费外送"


cuisine1 = Cuisine.create! :id => 1, :name => "炒菜", :restaurant => restaurant1
cuisine2 = Cuisine.create! :id => 2, :name => "主食", :restaurant => restaurant1
cuisine3 = Cuisine.create! :id => 3, :name => "主食", :restaurant => restaurant2
cuisine4 = Cuisine.create! :id => 4, :name => "米粉", :restaurant => restaurant3
cuisine5 = Cuisine.create! :id => 5, :name => "主食", :restaurant => restaurant4
cuisine6 = Cuisine.create! :id => 6, :name => "主食", :restaurant => restaurant5
cuisine7 = Cuisine.create! :id => 7, :name => "套餐", :restaurant => restaurant1
cuisine8 = Cuisine.create! :id => 8, :name => "盖饭", :restaurant => restaurant1


Dish.create! :id=>1, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 15.0, :name => "三鲜炒面(原价18，会员价15)"
Dish.create! :id=>2, :cuisine=>cuisine1, :restaurant => restaurant1, :price => 25.0, :name => "清炒四季豆（Marina)"
Dish.create! :id=>3, :cuisine=>cuisine1, :restaurant => restaurant1, :price => 33.0, :name => "豌豆辣牛肉（Marina)"
Dish.create! :id=>4, :cuisine=>cuisine1, :restaurant => restaurant1, :price => 15.0, :name => "西红柿牛腩"
Dish.create! :id=>5, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 2.0, :name => "热干面"
Dish.create! :id=>6, :cuisine=>cuisine2, :restaurant => restaurant1, :price => 13.0, :name => "牛肉粉"
Dish.create! :id=>28, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "铁板茄子 + 小炒木耳"
Dish.create! :id=>29, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "农家小炒肉 + 手撕包菜"
Dish.create! :id=>30, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "农家小炒肉 + 干煸四季豆"
Dish.create! :id=>31, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "江南小炒肉 + 酱香茄子"
Dish.create! :id=>32, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "板栗仔鸡 + 酱香茄子"
Dish.create! :id=>33, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "鱼香肉丝 + 酱香茄子"
Dish.create! :id=>34, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "豌豆辣牛肉 + 手撕包菜"
Dish.create! :id=>35, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "豌豆辣牛肉 + 干煸四季豆"
Dish.create! :id=>36, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "豌豆辣牛肉 + 清炒莴笋"
Dish.create! :id=>37, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "农家小炒 + 手撕包菜"
Dish.create! :id=>38, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "农家小炒 + 清炒莴笋"
Dish.create! :id=>39, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "腐竹烧肉 + 手撕包菜"
Dish.create! :id=>40, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "花肉海带 + 酸辣藕丁"
Dish.create! :id=>41, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "小炒黑木耳 + 醋溜土豆丝"
Dish.create! :id=>42, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "肉丝炒蒜苗 + 清炒大白菜"
Dish.create! :id=>43, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "肉丝炒蒜苗 + 醋溜土豆丝"
Dish.create! :id=>44, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "肉炒黑木耳 + 清炒大白菜"
Dish.create! :id=>45, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "腐竹烧肉 + 酱香茄子"
Dish.create! :id=>46, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "小炒猪肝+豆豉鲮鱼油麦菜"
Dish.create! :id=>47, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "酱爆鸡丁+口蘑菜心"
Dish.create! :id=>48, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "酱爆鸡丁+豆豉鲮鱼油麦菜"
Dish.create! :id=>49, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "江南小炒肉 + 醋溜土豆丝"
Dish.create! :id=>50, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "九宫山炒香干+清炒四季豆"
Dish.create! :id=>51, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "小炒鲜香菇+豆豉鲮鱼油麦菜"
Dish.create! :id=>52, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "花肉海带 + 香菇油菜"
Dish.create! :id=>53, :cuisine=>cuisine7, :restaurant => restaurant1, :price => 15.0, :name => "花肉海带 + 干锅花菜"
Dish.create! :id=>54, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 12.0, :name => "肉末豆腐饭"
Dish.create! :id=>55, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 12.0, :name => "红烧茄子饭"
Dish.create! :id=>56, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 15.0, :name => "宫保鸡丁饭"
Dish.create! :id=>57, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 15.0, :name => "鱼香肉丝饭"
Dish.create! :id=>58, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 15.0, :name => "西红柿鸡蛋饭"
Dish.create! :id=>59, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 18.0, :name => "红烧鱼块饭"
Dish.create! :id=>60, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 18.0, :name => "干烧豆角饭"
Dish.create! :id=>61, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 26.0, :name => "香菇鸡块饭"
Dish.create! :id=>62, :cuisine=>cuisine8, :restaurant => restaurant1, :price => 26.0, :name => "豆角烧排骨饭"

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
