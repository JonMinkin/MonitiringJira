require 'spec_helper'
describe ProjectsController do 
  before do
    user = FactoryGirl.create(:user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end 
  describe "GET #index" do
    it "populates an array of all projects" do
     project1 = create(:project, id: 1)
     create(:task, project_id: 1)
     project2 = create(:project, id: 2)
     create(:task, id: 2, project_id: 2)
      get :index
      expect(assigns(:projects).to_a).to match_array([project1, project2])
    end 
    it "radio" do
      get :index
      expect(assigns(:filter_radio)).to eq("created_at")
    end
    it "filter_date" do
      get :index
      expect(assigns(:filter_date)).to eq({:from => "2012-01-01", :to => "#{Date.today}"})
    end
    it "populates an array of all status" do
      get :index
      expect(assigns(:filter_status).to_a).to match_array(["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"])
    end 
    it "grafics" do
     project1 = create(:project, id: 1)
     create(:task, project_id: 1)
     project2 = create(:project, name: "test_project2", id: 2)
     create(:task, id: 2, project_id: 2)
      get :index
      expect(assigns(:grafics).to_a).to match_array([["test_project1", 2000.0], ["test_project2", 2000.0]])
    end
  end
  describe "GET #show" do
    it "populates an array of all tasks of project" do
      create(:project, id: 1)
      task1 = create(:task, id: 1, project_id: 1)
      task2 = create(:task, id: 2, project_id: 1)
      get :show, id: 1
      expect(assigns(:tasks).to_a).to match_array([task1, task2])
    end
    it "radio" do
      create(:project, id: 1)
      get :show, id: 1
      expect(assigns(:filter_radio)).to eq("created_at")
    end
    it "populates an hash of date" do
      create(:project, id: 1)
      get :show, id: 1
      expect(assigns(:filter_date)).to eq({:from => "2012-01-01", :to => "#{Date.today}"})
    end
    it "populates an array of all status" do
      create(:project, id: 1)
      get :show, id: 1
      expect(assigns(:filter_status).to_a).to match_array(["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"])
    end 
    it "grafics" do
      create(:project, id: 1)
      create(:task, summary: "test_task1", project_id: 1)
      create(:task, summary: "test_task1", id: 2, project_id: 1)
      get :show, id: 1
      expect(assigns(:grafics).to_a).to match_array([["2016-01-01".to_date, 4000.0]])
    end
    it "project" do
      proj = create(:project, id: 1)
      get :show, id: 1
      expect(assigns(:project).to_a).to match_array([proj])      
    end
    it "renders show view" do
      create(:project, id: 1)
      get :show, id: 1
      expect(response).to render_template :show
    end
  end
  describe "GET #download_xlsx" do
    it "populates an array of project" do

    end
  end
end
