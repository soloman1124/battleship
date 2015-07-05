#!/usr/bin/env rake
require 'rspec/core/rake_task'

task :app do
  require './app'
end

Dir[File.dirname(__FILE__) + '/lib/tasks/*.rb'].sort.each do |path|
  require path
end

RSpec::Core::RakeTask.new :spec do |task|
  task.rspec_opts = '--color --format nested'
end

task default: :spec
