# frozen_string_literal: true
# Remove existing same-named tasks
%w(ci ci:metrics).each do |task|
  klass = Rake::Task
  klass[task].clear if klass.task_defined?(task)
end

desc 'Run all specs, metrics and mutant'
task ci: %w(ci:metrics metrics:mutant)

namespace :ci do
  tasks = %w(
    metrics:coverage
    metrics:yardstick:verify
    metrics:rubocop
    metrics:flog
    metrics:flay
    spec:integration
  )

  desc 'Run metrics (except mutant)'
  task metrics: tasks
end
