require 'spec_helper'
require 'git_helper'
require 'grit'

describe GitPoller do
  #it 'can poll a git repository for changes' do
  #  lambda {GitPoller.changed?('git://github.com/rails/rails.git')}.should_not raise_error
  #end	

  before do 
    GitPoller.reset_watched
  end

  it 'can start watching a new repository' do
    poller = GitPoller.watch('dio', "git://github.com/alexmreis/dio.git");
    poller.should be
    poller.repo.commits.should_not be_empty
  end

  it 'can poll a repository' do
    poller = GitPoller.watch('fixture', "git://github.com/alexmreis/dio.git");
    GitHelper.touch_and_commit(poller.repo_path)
    poller.changed?.should be true
  end

  it 'can update itself after polling' do
    poller = GitPoller.watch('fixture', "git://github.com/alexmreis/dio.git");
    GitHelper.touch_and_commit(poller.repo_path)
    poller.update
    poller.changed?.should_not be
  end
end