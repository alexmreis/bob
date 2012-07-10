require 'grit'
class GitPoller

  attr_accessor :project_name, :project_url

  def self.reset_watched
    @@watched = Hash.new
  end

  def self.watched
    @@watched ||= Hash.new
  end

  def self.watch(project)
    @@watched ||= Hash.new
    return @@watched[project.name] if @@watched.has_key?(project.name)
    
    poller = GitPoller.new(project)
    git = Grit::Git.new(poller.repo_path) 
    git.clone({}, project.repository_url, poller.repo_path)
    @@watched[project.name] = poller
    poller
  end

  def self.update_all
    @@watched.values.each do |poller|
      poller.update if poller.changed?
    end
  end

  def initialize(project)
    @project_name = project.name
    @project_url = project.repository_url
    @project = project
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
    @project.last_updated = DateTime.now
  end

  def pull
    puts "Pulling #{@project.name}"
    git = Grit::Git.new(repo_path)     
    git.pull
    repo
  end

  def last_commit
    repo.commits.first
  end

  def repo_path
    "#{Bob.root}/projects/#{@project_name}"
  end
end
