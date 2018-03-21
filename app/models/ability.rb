class Ability
  include CanCan::Ability
   
  def initialize(user)
    user ||= User.new
    if user.roles.first.present?
      roles = user.roles.all
      roles.each do |role|
        permissions = role.permissions
        permissions.each do |permission|
          can permission.action.to_sym, permission.klass.constantize
        end
      end
    end
  end  
end
