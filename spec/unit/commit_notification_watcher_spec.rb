require 'spec_helper'
require 'pony'

describe CommitNotificationWatcher do   
  before do
    GitPoller.reset_watched
  end

  it 'fails' do
    expect(false).toBe(true)
  end
  it 'should notify me when there is a new commit' do
    Pony.stub(:mail)
    Pony.should_receive(:mail)
    
    poller = GitPoller.watch(project = Project.new(name: 'fixture2', repository_url: "git://github.com/alexmreis/dio.git"));
    project.watch(CommitNotificationWatcher.new)
    GitHelper.touch_and_commit(poller.repo_path)
    GitPoller.update_all
  end
end
