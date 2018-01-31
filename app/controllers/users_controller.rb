class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    unless current_user.admin?
      redirect_to root_path, :alert => "Access denied"
    end
    show_users
  end

  private

  def show_users
    @users = User.all.order(email: :desc)
  end

end
