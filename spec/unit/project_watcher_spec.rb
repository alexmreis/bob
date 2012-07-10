require 'spec_helper'
require 'pony'

describe ProjectWatcher do   
  before do
    GitPoller.reset_watched
  end
  it 'should notify me when there is a new commit' do
    Pony.stub(:mail)
    Pony.should_receive(:mail)
    
    poller = GitPoller.watch(project = Project.new(name: 'fixture', repository_url: "git://github.com/alexmreis/dio.git"));
    project.watch(ProjectWatcher.new)
    GitHelper.touch_and_commit(poller.repo_path)
    GitPoller.update_all
  end
end
