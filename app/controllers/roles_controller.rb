class RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def show
    @permissions  = Permission.all
    unless  @role = Role.where(:id => params[:id]).first
      redirect_to "errors#error_404"
    end 
    if params[:user_id].present?
      users = @role.users
      user = @role.users.find(params[:user_id])
      users.delete(user)
    end
    if params[:permission_id].present?
      permissions = @role.permissions
      permission = @role.permissions.find(params[:permission_id])
      permissions.delete(permission)
    end
    if  params["role"].present?
      if  params["role"]["user_ids"].present?
        params["role"]["user_ids"].each do |users_role_id|
          if users_role_id.present?
            @role.users << User.find(users_role_id)
          end 
        end
      end

    if  params["role"]["permission_ids"].present?
        params["role"]["permission_ids"].each do |permissions_role_id|
          if permissions_role_id.present?
            @role.permissions << Permission.find(permissions_role_id)
          end 
        end
      end



    end
  end

  def new
  	
  end

  def create
    @role = Role.create(role_params)
    redirect_to roles_path
  end

  def edit
  	@role = Role.find(params[:id])
  end
  
  def update
  	@role = Role.find(params[:id])
  	@role.update_attributes(role_params)
  	redirect_to roles_path
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to roles_path
  end

  private

  def role_params
    params.require(:role).permit!
  end
end
