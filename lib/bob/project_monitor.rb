require 'rack'
require 'rack/showexceptions'

class ProjectMonitor

  def self.start
    t = Thread.new do
      Rack::Handler::WEBrick.run \
        Rack::ShowExceptions.new(Rack::Lint.new(ProjectMonitor.new)),
        :Port => 3100
    end
    t.run
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new
    res.write '<html><head><title>BoB - Projects</title></head><body><h3>Projects</h3><ul>'
    Project.all.each do |p|
      res.write "<li style=\"background-color: #{p.successful? ? 'green' : 'red'}\">#{p.name} - Last updated #{p.last_updated}</li>"
    end
    res.write '</ul>'
    res.write '<script> window.setTimeout(function() { window.location.reload() }, 2000);</script> '
    res.write '</body></html>'
    res.finish
  end
end
