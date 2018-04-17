class User < ApplicationRecord
  has_secure_password
  has_many :lists
  validates_presence_of :email, :name
  validates_presence_of :password
  validates_uniqueness_of :email

  def first_name
    self.name.split(" ").first
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.name = auth.info.name
      user.password = SecureRandom.hex
    end
  end
end
