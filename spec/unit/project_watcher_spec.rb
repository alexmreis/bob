require 'spec_helper'
require 'pony'

describe ProjectWatcher do   
  before do
    GitPoller.reset_watched
  end
  it 'should notify me when there is a new commit' do
    Pony.stub(:mail)
    Pony.should_receive(:mail)
    
    poller = GitPoller.watch('fixture', "git://github.com/alexmreis/dio.git");
    GitHelper.touch_and_commit(poller.repo_path)
    ProjectWatcher.update_all
  end
end