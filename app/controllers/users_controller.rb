class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    unless current_user.admin?
      redirect_to root_path, :alert => "Access denied"
    end
    show_users
  end

  def toggle_admin
    if !current_user.admin?
      redirect_to mymatches_path
    end
    admin_count = User.where(admin: true).count
    user_id = params[:user].to_i
    if User.where(id: user_id).count == 0
      redirect_to users_path, :alert => "Unknown user"
    else
      user = User.find(user_id)
      if user.admin && admin_count < 2
        redirect_to users_path, :alert => "Sorry buddy, we do need an admin"
      else
        user.toggle_admin(user_id)
        redirect_to users_path
      end
    end
  end

  private

  def show_users
    @users = User.all
  end

end
