require 'axlsx'
class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :download_xlsx]
  respond_to :xlsx
  include FilterData
  def index
    @filter_radio = filter_radio(params[:radio])
    @filter_date = filter_date(params[:from], params[:to])
    @filter_status = filter_status(params[:status])
    @projects = Project.by_created_at(@filter_date).by_status(@filter_status)
    @grafics = Project.grafics_project(@filter_date, @filter_status)
  end
  def show
    @filter_radio = filter_radio(params[:radio])
    @filter_date = filter_date(params[:from], params[:to])
    @filter_status = filter_status(params[:status])
    @grafics = filter_tasks.group(@filter_radio).sum("gross")
    @tasks = filter_tasks
    @project = Project.where(:id => params[:id])
    unless  @project.present?
      redirect_to url_for(:controller => :errors, :action => :error_404)
  	end      
  end

  def create
    Project.create(project_params)
  end

  def download_xlsx
    @project = Project.where(id: params[:id]).first
    @sumGross = grouped_gross_sum
    @sumNet = grouped_net_sum
    @paid_tasks = filter_tasks.paid.group("id").sum("gross")
    @tasks = filter_tasks
    respond_to do |format|
      format.xlsx {render :xlsx => "download_xlsx", 
                          :filename => @project.name}
     end
  end
  private
  def filter_tasks
    Task.by_project_id(params[:id]).datefilter(filter_radio(params[:radio]), filter_date(params[:from], params[:to])).by_status(filter_status(params[:status]))
  end
  def grouped_gross_sum
    Task.datefilter(filter_radio(params[:radio]), filter_date(params[:from], params[:to])).by_status(filter_status(params[:status])).group("project_id").sum("gross")
  end
  def grouped_net_sum
    Task.datefilter(filter_radio(params[:radio]), filter_date(params[:from], params[:to])).by_status(filter_status(params[:status])).group("project_id").sum("net")
  end
  def project_params
    params.require(:project).permit(:name, :key )
  end
end
