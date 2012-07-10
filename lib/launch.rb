#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'bob'

watcher = ProjectWatcher.new

Project.all.each do |project|
  GitPoller.watch(project) 
  project.watch(watcher)
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
