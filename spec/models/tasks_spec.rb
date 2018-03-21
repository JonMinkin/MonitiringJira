require 'spec_helper'
describe Task do  
  let(:filter){{:from => "2014-01-01", :to => "2016-10-01"}}
  let(:task){create(:task)}
  it "return sum gross" do
    create(:project, id: 1)
    create(:task, project_id: 1)
    expect(Task.sumGross(1, "created_at", filter, "Done")).to eq(2000.0)
  end
  it "return sum net" do
    create(:project, id: 1)
    create(:task, project_id: 1)
    expect(Task.sumNet(1, "created_at", filter, "Done")).to eq(100.0)
  end
  it "return sum gross" do
    create(:project, id: 1)
    create(:task, project_id: 1)
    expect(Task.tasks_total(1, "created_at", filter, "Done")).to eq(2000.0)
  end
  context "#datefilter" do
    it "return tasks alter filter[:radio] created_at" do
      radio = "created_at"
      expect(Task.datefilter(radio, filter)).to match_array(task) 
    end
    it "return tasks alter filter[:radio] updated_at" do
      radio = "updated_at"
      expect(Task.datefilter(radio, filter)).to match_array(task) 
    end
    it "return tasks alter filter[:radio] due_date" do
      radio = "due_date"
      expect(Task.datefilter(radio, filter)).to match_array(task) 
    end
  end
  context "#assignee_all" do
    it "return all assignee" do
      create(:task)
      expect(Task.assignee_all).to match_array("Женя")
    end
    it "return nil" do
      create(:task, assignee: nil)
      expect(Task.assignee_all[0]).to be_nil
    end
  end
end
