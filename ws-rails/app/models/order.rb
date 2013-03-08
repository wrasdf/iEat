class Order < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :order_dishes

  attr_accessible :user, :group
  # attr_accessible :title, :body
end
