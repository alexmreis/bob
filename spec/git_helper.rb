require 'grit'
class GitHelper
  def self.touch_and_commit(repo_path)
    git = Grit::Repo.init(repo_path)
    file_name = "#{Time.now.to_i.to_s}"
    f = File.new("#{repo_path}/#{file_name}", "w")
    f.write("touch_and_commit")    
    f.close
    Dir.chdir(repo_path) { git.add(file_name) }
    git.commit_index('Touch and commit');
  end
end