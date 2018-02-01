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
    user_id = params[:user]
    user = User.new
    user.toggle_admin(user_id)
    redirect_to users_path
  end


  private

  def show_users
    @users = User.all
  end

end
