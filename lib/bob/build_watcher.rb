class BuildWatcher
  def update(project)
    build(project)
  end

  def build(project)
    puts "Building #{project.name}, current dir is: " + `pwd`
    output = `cd #{project.project_path}; pwd; bundle exec rake spec`
    puts output
    status = $?.to_i
    if status != 0
      puts "BUILD FAILED"
    else
      puts "Build successful"
    end
  end
end
