class Role < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :users, join_table: :roles_users
  has_and_belongs_to_many :permissions, join_table: :permissions_roles
end
