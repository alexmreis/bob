require 'spec_helper'
describe Project do
  describe "all" do
    it 'loads a list of projects from a yaml file' do
      Project.should have(2).all
    end

    it "should load projects as objects, and not a hash" do
      Project.all.first.should respond_to :name
    end
  end

  describe "observable" do 
    it "allows watchers to register and receive updates" do
      project = Project.new(name: "dio", url: "http://dio.com")
      project.watch(watcher = double("watcher"))
      
      watcher.should_receive(:update).with(project)
      project.notify
    end
  end
end
