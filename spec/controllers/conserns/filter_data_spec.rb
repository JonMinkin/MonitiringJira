require 'spec_helper'
include FilterData
describe FilterData do 
  context "filter_date" do
    it "params[:from] and params[:to] nil" do
      expect(filter_date("", "")).to include({:from=>"2012-01-01", :to=>"#{Date.today}"})
    end
    it "params[:from] present and params[:to] nil"do
      expect(filter_date("2013-01-01", "")).to include({:from=>"2013-01-01", :to=>"#{Date.today}"})
    end
    it "params[:from] nil and params[:to] present"do
      expect(filter_date("", "2014-01-01")).to include({:from=>"2012-01-01", :to=>"2014-01-01"})
    end
    it "params[:from] and params[:to] present"do
      expect(filter_date("2013-01-01", "2014-01-01")).to include({:from=>"2013-01-01", :to=>"2014-01-01"})
    end
  end
  context "filter_status" do
  	it "params[:status] nil" do
  	  expect(filter_status("")).to match_array(["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"])
  	end
  	it "params[:status] present" do
  	  expect(filter_status("Done")).to eq("Done")
  	end
  	it "params[:status] present multitask" do
  	  expect(filter_status(["Done", "In Review"])).to match_array(["Done", "In Review"])
  	end
  end
  context "filter_radio" do
  	it "params[:radio] nil" do
  	  expect(filter_radio("")).to eq("created_at")
  	end
  	it "params[:radio] present" do
  	  expect(filter_radio("updated_at")).to eq("updated_at")
  	end
  end 
  context "filter_assignee" do
  	it "params[:assignee] nil" do
  	  create(:task)
  	  expect(filter_assignee("")).to match_array(["Женя"])
  	end
  	it "params[:assignee] present" do
  	  create(:task)
  	  create(:task, id: 2, assignee: "Вася")
  	  expect(filter_assignee("Вася")).to eq("Вася")
  	end
  	it "params[:assignee] present multitask" do
  	  create(:task)
  	  create(:task, id: 2, assignee: "Вася")
  	  create(:task, id: 3, assignee: "Иван")
  	  expect(filter_assignee(["Вася", "Иван"])).to match_array(["Вася", "Иван"])
  	end
  end
end