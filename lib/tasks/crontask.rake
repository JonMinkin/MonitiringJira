require 'rubygems'
require 'pp'
require 'jira'
namespace :data do
  desc "Import data"
  task :imports => :environment do
    username = "****"
    password = "****"
    options = {
      :username => username,
      :password => password,
      :site => '####',
      :context_path => '',
      :auth_type => :basic,
      :use_ssl => false,
      :debug =>true}
    client = JIRA::Client.new(options)
    projects = client.Project.all
    projects.each do |project|
      project.issues.each do |issue|
        if Project.where(:name => project.name).present?
          i = Project.where(:name => project.name).first
          if Task.where(:key => issue.key).present?
            Task.where(:key => issue.key).first.update_attributes(
              :summary => issue.summary,
              :priority => issue.priority.try(:name),
              :due_date => issue.duedate,
              :status => issue.status.try(:name),
              :gross => issue.fields["customfield_10200"] || 0,
              :net => issue.fields["customfield_10201"] || 0,
              :paid  => to_boolean(issue.fields["customfield_10304"]),
              :assignee => issue.assignee.try(:name),
              :reporter => issue.reporter.try(:name),
              :description => issue.description,
              :created_at => issue.created,
              :updated_at => issue.updated)
          end
        end
        Project.where(:name => project.name).first_or_create do |projects|
          projects.name = project.name
          projects.key = project.key
        end
        i = Project.where(:name => project.name).first
        Task.where(:key => issue.key).first_or_create do |task|
          task.project_id = i.id
          task.key = issue.key
          task.summary = issue.summary
          task.priority = issue.priority.try(:name)
          task.due_date = issue.duedate
          task.status = issue.status.try(:name)
          task.gross = issue.fields["customfield_10200"] || 0
          task.net = issue.fields["customfield_10201"] || 0
          task.paid = to_boolean(issue.fields["customfield_10304"])
          task.assignee = issue.assignee.try(:name)
          task.reporter = issue.reporter.try(:name)
          task.description = issue.description
          task.created_at = issue.created
          task.updated_at = issue.updated
        end
      end
    end
  end
  def to_boolean(arr)
    if arr.present?
      arr[0]["value"] == "true"
    end
  end
end  
