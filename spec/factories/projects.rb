FactoryGirl.define do
  factory :project do
    name "test_project1"
    key  "test_key"
    factory :project_with_tasks do
      after(:create) do |project|
        create(:task, project: project)
      end
    end
  end 
end