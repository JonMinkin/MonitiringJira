require 'spec_helper'
describe Project do  
  it "grafics_project" do
    create(:project_with_tasks)
    status = "Done"
    filter = {:from => "2014-01-01", :to => "2016-10-01"}
    expect(Project.grafics_project(filter, status)).to match_array([["test_project1", 2000.0]])
  end 
end