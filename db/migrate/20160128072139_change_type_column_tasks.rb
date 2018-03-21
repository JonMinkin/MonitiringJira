class ChangeTypeColumnTasks < ActiveRecord::Migration
  def change
  	change_column :tasks, :created_at, :date
  	change_column :tasks, :updated_at, :date
  end
end
