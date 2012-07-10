class Project
  attr_accessor :name, :repository_url
  attr_reader :last_updated
  
  @@projects = nil
  
  def self.all
    @@projects ||= self.load
    @@projects.values
  end

  def self.each(&block)
    self.all.each(block)
  end

  def self.load
    projects = {}
    yaml = YAML.load_file("#{Bob.root}/projects.yml")
    yaml.each { |key, value| projects[key] = self.new(name: key, repository_url: value["url"]) }
    projects
  end

  def initialize(params)
    @name = params[:name]
    @repository_url = params[:repository_url]
    @watchers = []
  end

  def watch(watcher)
    @watchers << watcher
  end

  def notify
    @watchers.each { |w| w.update(self) }
  end

  def last_updated=(value)
    @last_updated = value
    notify
  end

end
