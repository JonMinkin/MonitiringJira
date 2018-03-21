class RemoveColumnCreatedTaskAndUpdatedTaskTableTasks < ActiveRecord::Migration
  def change
  	change_table :tasks do |t|
      t.remove :created_task, :updated_task
  	end
  end
end
