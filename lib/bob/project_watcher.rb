require 'pony'

class ProjectWatcher
  def update (project)
    puts "Project #{project.name} updated. Notifying"
    notify(project)
  end

  def notify(project)
      Pony.mail(
        :to => 'alex@alexmreis.com', 
        :from => 'bob@thebuilder.com',
        :subject => "New commit in [#{project.name}]",
        :body => "There is a new commit to the project.")
  end
end
