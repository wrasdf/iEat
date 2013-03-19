class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  attr_accessor :login
  attr_accessible :login

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  before_save :ensure_authentication_token

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    where(conditions).where(["lower(name) = :value", { :value => conditions[:name].downcase }]).first
  end


end
