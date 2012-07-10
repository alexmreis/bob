require "bob/version"
require "bob/git_poller"
require "bob/commit_notification_watcher"
require "bob/build_watcher"
require "bob/project"
module Bob
  class << self

    def root
      @root ||= Dir.pwd
    end

    def run
      watcher = CommitNotificationWatcher.new
      builder = BuildWatcher.new

      Project.all.each do |project|
        GitPoller.watch(project) 
        project.watch(watcher)
        project.watch(builder)
      end

      puts "Starting polling"
      t = Thread.new do
        loop do 
          GitPoller.update_all
          sleep 2
        end
      end
      t.run
      puts "Setup complete"
      t.join
    end

  end
end
