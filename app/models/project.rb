class Project < ActiveRecord::Base
  has_many :tasks, :inverse_of => :project

  acts_as_xlsx

  scope :by_created_at, ->(filter_date) {joins(:tasks).where("tasks.created_at between ? and ?", filter_date[:from], filter_date[:to])}
  scope :by_status, ->(status) {joins(:tasks).where("tasks.status in (?)", status).order(id: :asc).uniq}
  scope :paid, ->{joins(:tasks).where("tasks.paid = true").order(id: :asc).uniq}

  def self.grafics_project(filter_date, status)
    grafics = []
    summa_tasks = Task.by_created_at(filter_date).by_status(status).paid.group("project_id").sum("gross")
    projects = Project.by_created_at(filter_date).by_status(status).paid
    projects.each do |project|
      grafics << [project.name, summa_tasks[project.id]]
    end
    grafics  
  end
end
