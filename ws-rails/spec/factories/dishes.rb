# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dish do
    name "MyString"
    price 1.5
    description "MyText"
    image_url "MyString"
    restaurant nil
  end
end
