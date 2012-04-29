require 'grit'
class GitPoller

  attr_accessor :project_name, :project_url

  def self.reset_watched
    @@watched = Hash.new
  end

  def self.watched
    @@watched ||= Hash.new
  end

  def self.watch(project_name, project_url)
    poller = GitPoller.new(project_name)
    poller.project_url = project_url

    return watched[project_name] if watched.has_key?(project_name)
    
    git = Grit::Git.new(poller.repo_path) 
    git.clone({}, project_url, poller.repo_path)
    @@watched ||= Hash.new
    @@watched[project_name] = poller
    poller.update
    poller
  end

  def initialize(project_name)
    @project_name = project_name    
    update if File.exists?(repo_path)    
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