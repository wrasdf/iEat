# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name "MyString"
    description "MyText"
    user nil
    due_date "2013-02-20 20:51:06"
    restaurant nil
  end
end
