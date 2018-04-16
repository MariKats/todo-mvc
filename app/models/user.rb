class User < ApplicationRecord
  has_secure_password
  has_many :lists
  validates_presence_of :email, :password, :name
  validates_uniqueness_of :email

  def first_name
    self.name.split(" ").first
  end
end
