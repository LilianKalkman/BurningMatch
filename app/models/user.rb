class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :matches

  def name
    email.partition("@")[0].capitalize
  end

  def toggle_admin(user_id)
    user = User.find(user_id)
    user.admin = !user.admin
    user.save
  end

end
