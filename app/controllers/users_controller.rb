class UsersController < ApplicationController
  def index
    show_users
  end

  private

  def show_users
    @users = User.all.order(email: :desc)
  end

  def show
  end
  
end
