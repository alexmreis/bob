require "bob/version"
require "bob/git_poller"
require "bob/commit_notification_watcher"
require "bob/project"
module Bob
  class << self
    @@root = Dir.pwd
  end
end
