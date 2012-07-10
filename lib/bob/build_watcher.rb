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
      puts "\0[33mBUILD FAILED\0"
    else
      puts "Build successful"
    end
  end
end
