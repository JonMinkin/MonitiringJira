class Task < ActiveRecord::Base
  belongs_to :project, :inverse_of => :tasks
  scope :by_created_at, ->(filter){where("created_at between ? and ?", filter[:from], filter[:to])}
  scope :by_updated_at, ->(filter){where("updated_at between ? and ?", filter[:from], filter[:to])}
  scope :by_due_date, ->(filter){where("due_date between ? and ?", filter[:from], filter[:to])}
  scope :by_status, ->(status){where(status: status)}
  scope :paid, ->{where(paid: true)}
  scope :by_project_id, -> (id){where(project_id: id)}
  scope :by_assignee, -> (filter){where(assignee: filter)}
  def self.datefilter(radio, filter)
    case radio
    when "created_at"
      self.by_created_at filter
    when "updated_at"
      self.by_updated_at filter 
    when "due_date"
      self.by_due_date filter
    end
  end
  def self.assignee_all
    Task.select('DISTINCT assignee').map{|a| a[:assignee]}.compact  	
  end
  def self.tasks_total(id, radio, filter, status)
    by_project_id(id).datefilter(radio, filter).by_status(status).paid.sum("gross")
  end
  def self.sumGross(id, radio, filter, status)
    where(project_id: id).datefilter(radio, filter).by_status(status).sum("gross")
  end
  def self.sumNet(id, radio, filter, status)
    where(project_id: id).datefilter(radio, filter).by_status(status).sum("net")
  end
end
