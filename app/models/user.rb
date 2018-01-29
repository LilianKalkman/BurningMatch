class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true


  def self.current_user
  Thread.current[:user]
end

def self.current_user=(user)
  Thread.current[:user] = user
end
end
