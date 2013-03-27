class Order < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :order_dishes
  attr_accessible :user, :group, :paid

  def has_unpaid_orders

  end

  def has_payback_orders

  end
end
