namespace :data do
  desc "destroy"
  task :destroy => :environment do
  	Project.destroy_all
  	Task.destroy_all
  end
end