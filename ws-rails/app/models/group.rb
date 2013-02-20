class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  attr_accessible :description, :due_date, :name
end
