#!/usr/bin/ruby

# Usage: `sb` in project directory
# Configuration: see config.rb

script_dir = File.dirname(File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__)

load "#{script_dir}/config.rb"
SEARCH_ROOTS.map!{ |path| File.expand_path(path) }

project_root = Dir.pwd

path_candidates = []

def open_project(project_filename)
  system "subl '#{project_filename}'"
end

def create_project(project_root)
  project_template = File.read("#{script_dir}/project_template.json")
  project_filename = "#{project_root}/#{File.basename(project_root)}.sublime-project"
  puts "Creating Sublime Text project #{project_filename}"
  File.open(project_filename, 'w') do |f|
    f.puts project_template.gsub('PROJECT_ROOT', project_root)
  end
  project_filename
end

until SEARCH_ROOTS.include?(project_root)
  project_name = Dir["#{project_root}/*.sublime-project"].first

  open_project(project_name) && exit if project_name

  path_candidates.push(project_root)
  project_root = File.dirname(project_root)
end

if path_candidates.length == 1
  print "Create ST project in #{path_candidates.first}? [y]/n: "
  if ["y", ""].include? gets.strip
    open_project(create_project(path_candidates.first))
  else
    puts "Aborting"
  end
elsif path_candidates.empty?
  puts "Don't know where to create ST project"
else
  path_candidates.each_with_index do |path, i|
    puts "#{i + 1}) #{path}"
  end
  print "Choose root for ST project (default is 1): "

  input = gets.strip
  if input.empty?
    index = 0
  else
    begin
      index = Integer(input) - 1
    rescue
      index = -1
    end
  end
  if index >= 0 && index < path_candidates.length
    open_project(create_project(path_candidates[index]))
  else
    puts "Bad index"
  end
end
