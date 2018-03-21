require 'spec_helper'
describe TasksController do 
  before do
    user = FactoryGirl.create(:user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end 
  describe "GET #index" do
    it "populates an array of all tasks" do
      task1 = create(:task, id: 1)
      task2 = create(:task, id: 2)
      get :index
      expect(assigns(:tasks).to_a).to match_array([task1, task2])
    end 
    it "populates an hash of date" do
      get :index
      expect(assigns(:filter_date)).to eq({:from => "2012-01-01", :to => "#{Date.today}"})
    end
    it "populates an array of all status" do
      get :index
      expect(assigns(:filter_status).to_a).to match_array(["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"])
    end 
    it "populates an array of all assignee" do
      create(:task, id: 1, assignee: "Володя")
      get :index
      expect(assigns(:assignee).to_a).to match_array(["Володя"])
    end
    it "renders index view" do
      get :index
      expect(response).to render_template :index
    end
  end
  describe "GET #show" do
  	it "populates an task" do
  	  task1 = create(:task, summary: "test_task1", id: 1)
      get :show, id: 1
      expect(assigns(:task)).to eq(task1)
    end
    it "renders show view" do
      create(:task, id: 1)
      get :show, id: 1
      expect(response).to render_template :show
    end
  end
end