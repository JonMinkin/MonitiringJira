module FilterData
  extend ActiveSupport::Concern
  PROJECT_STATES = ["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"]
  def filter_date(paramsFrom, paramsTo)
    {:from => paramsFrom.present? ? paramsFrom : "2012-01-01",
    :to => paramsTo.present? ? paramsTo : "#{Date.today}"}
  end
  def filter_status(paramsStatus)
    paramsStatus.present? ? paramsStatus : PROJECT_STATES
  end
  def filter_radio(paramsRadio)
    paramsRadio.present? ? paramsRadio : "created_at"
  end
  def filter_assignee(paramsAssignee)
    paramsAssignee.present? ? paramsAssignee : Task.assignee_all
  end
end
