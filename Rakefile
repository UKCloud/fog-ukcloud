require "bundler/gem_tasks"
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :record do
  ENV['VCR_RECORDING'] = 'true'
  sh("export FOG_MOCK=false && bundle exec rspec")
end
