class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #validates :email, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_and_belongs_to_many :roles, join_table: :roles_users
    def admin?
      if self.role_id.present?
        Role.find(self.role_id).name == "admin"
      end
    end

end
