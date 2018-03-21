FactoryGirl.define do
  factory :task do
    id         1
  	project_id 1
    key        "task_1"
  	updated_at "2016-01-01"
    created_at "2016-01-01"
    due_date   "2016-01-01"
    net        100    
    gross      2000
    paid       true
    status     "Done"
    summary    "test_task"
    assignee   "Женя"
    reporter   "Володя"
    description  "Описание задачи"
  end
end