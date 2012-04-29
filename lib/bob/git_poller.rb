require 'grit'
class GitPoller

  attr_accessor :project_name
  def self.reset_watched
    @@watched = Hash.new
  end

  def self.watch(project_name, project_url)
    poller = GitPoller.new(project_name)

    # @@watched ||= Hash.new
    # return poller if @@watched.has_key?(project_name)

    # @@watched[project_name] = {url: project_url}
    git = Grit::Git.new(poller.repo_path) 
    git.clone({},"git://github.com/alexmreis/dio.git", poller.repo_path)
    poller
  end

  def initialize(project_name)
    @project_name = project_name    
    update
  end    

  def changed?
    pull
    @current_commit.sha != last_commit.sha
  end
  
  def repo
    Grit::Repo.new(repo_path)
  end

  def update
    @current_commit = last_commit
  end

  def pull
    git = Grit::Git.new(repo_path)     
    git.pull
    repo
  end

  def last_commit
    repo.commits.first
  end

  def repo_path
    "./projects/#{@project_name}"
  end
end