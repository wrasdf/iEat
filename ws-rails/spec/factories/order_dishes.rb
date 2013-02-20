# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_dish do
    order nil
    dish nil
    quantity 1
  end
end
