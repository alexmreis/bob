require 'pony'

class ProjectWatcher
  def self.update_all
    GitPoller.watched.values.each do |project|
      puts "Polling #{project.project_name}"
      next unless project.changed?
      
      puts "Project #{project.project_name} updated. Notifying"
      Pony.mail(
        :to => 'alex@alexmreis.com', 
        :from => 'bob@thebuilder.com',
        :subject => "New commit in [#{project.project_name}]",
        :body => "There is a new commit to the project.")
      project.update
    end
  end
end