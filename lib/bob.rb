require "bob/version"
require "bob/git_poller"
require "bob/project_watcher"
require "bob/project"
module Bob
  class << self
    def root
      Dir.pwd
    end
  end
end
