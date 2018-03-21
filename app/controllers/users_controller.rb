class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    unless  @user = User.where(:id => params[:id]).first
      redirect_to "errors#error_404"
    end 
    @permissions = @user.roles.first.permissions
  end

  def edit
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end
end
