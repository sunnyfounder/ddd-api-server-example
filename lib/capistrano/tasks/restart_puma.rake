namespace :puma do
  Rake::Task[:restart].clear_actions

  desc 'Overwritten puma:restart task'
  task :restart do
    puts 'Overwriting puma:restart to ensure that puma is running. Effectively, we are just starting Puma.'
    puts 'A solution to this should be found.'
    invoke 'puma:stop'
    sleep 2
    invoke 'puma:start'
  end
end
