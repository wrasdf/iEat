class Order < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  # attr_accessible :title, :body
end
