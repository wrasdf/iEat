class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  has_many :orders
  attr_accessible :id, :user, :restaurant, :description, :due_date, :name

  validates_presence_of :user, :restaurant, :due_date


end
