class TasksController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show]
  include FilterData
  def index
    @filter_date = filter_date(params[:from], params[:to])
    @filter_status = filter_status(params[:status])
    @assignee = filter_assignee(params[:assignee])
  	@tasks = Task.by_created_at(@filter_date).by_assignee(@assignee).by_status(@filter_status)
  end
  def show
    unless  @task = Task.where(:id => params[:id]).first
      redirect_to "errors#error_404"
    end   
  end
end