#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'bob'

projects = YAML.load_file('projects.yml')
projects.keys.each do |project|
  GitPoller.watch(project, project["url"])  
end

puts "Starting polling"
t = Thread.new do
  loop do 
    ProjectWatcher.update_all
    sleep 2
  end
end
t.run
t.join
puts "Setup complete"