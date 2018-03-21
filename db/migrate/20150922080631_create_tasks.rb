class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer  :project_id
      t.string   :key
      t.string   :summary
      t.string   :priority
      t.date     :due_date
      t.string   :status
      t.float    :gross
      t.float    :net
      t.string   :assignee
      t.string   :assignee_email
      t.string   :reporter
      t.string   :reporter_email
      t.boolean  :paid
      t.text     :description
      t.date     :created_task
      t.date     :updated_task
      t.timestamps null: false
    end
    add_index :tasks, :created_task
    add_index :tasks, :updated_task
    add_index :tasks, :due_date
    add_index :tasks, :status
    add_index :tasks, :assignee
    add_index :tasks, :reporter
  end
end
