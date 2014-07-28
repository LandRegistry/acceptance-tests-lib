require 'cucumber/rake/task'
require 'parallel_tests/tasks'

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--format progress --tags ~@wip --tags ~@removed"
end

# Tag a scenario @only while you work on it, because less noise.
Cucumber::Rake::Task.new(:only) do |t|
  t.cucumber_opts = "--format pretty --tags @only"
end

namespace :features do
  desc "Run all features"
  Cucumber::Rake::Task.new(:all) do |t|
    t.cucumber_opts = "--format progress"
  end
end
