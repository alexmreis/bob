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
    poller = GitPoller.watch(Project.new(name: 'dio', repository_url: "git://github.com/alexmreis/dio.git"));
    poller.should be
    poller.repo.commits.should_not be_empty
  end

  it 'can poll a repository' do
    poller = GitPoller.watch(Project.new(name: 'pollworks', repository_url: "git://github.com/alexmreis/dio.git"));
    GitHelper.touch_and_commit(poller.repo_path)
    poller.changed?.should be true
  end

  it 'can update itself after polling' do
    project = Project.new(name: 'fixture', repository_url: "git://github.com/alexmreis/dio.git")
    project.stub(:last_updated=)

    poller = GitPoller.watch(project)
    project.should_receive(:last_updated=).once
    GitHelper.touch_and_commit(poller.repo_path)
    poller.update
    poller.changed?.should_not be
  end

  it 'should have a new watched project after invoking watch' do
    poller = GitPoller.watch(Project.new(name: 'fixture', repository_url: "git://github.com/alexmreis/dio.git"));
    GitPoller.watched['fixture'].should be
  end
end
