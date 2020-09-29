# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "sunny_founder_api_server"
set :repo_url, "git@github.com:sunnyfounder/api-server.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/apps/#{fetch :application}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# set :rvm_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
# set :rbenv_map_bins, %w(rake gem bundle ruby sidekiq)

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_restart_command, 'bundle exec rackup'
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_threads, [ENV['THREADS_COUNT'], ENV['THREADS_COUNT']]
set :puma_workers, ENV['WEB_CONCURRENCY']
set :puma_daemonize, true
# set :puma_bind, "unix:///#{shared_path}/tmp/sockets/puma.sock"

set :init_system, :systemd
set :service_unit_name, "sidekiq-#{fetch(:stage)}.service"

set :rollbar_token, ENV['ROLLBAR_TOKEN']
set :rollbar_env, fetch(:stage)
set :slackistrano, {
  channel: '#notify-deploy',
  webhook: ENV['SLACK_DEPLOY_WEBHOOK'],
  slack_username: 'deploy',
  slack_run_updating: true,
  slack_run_updated: true,
  slack_run_failed: true,
  slack_msg_updating: "`#{fetch :slack_deploy_user}` has started deploying branch `#{fetch :branch}` of #{fetch :application} to `#{fetch :stage, 'an unknown stage'}`",
  slack_msg_updated: "`#{fetch :slack_deploy_user}` has finished deploying branch `#{fetch :branch}` of #{fetch :application} to `#{fetch :stage, 'an unknown stage'}`",
  slack_msg_failed: "*ERROR!* `#{fetch :slack_deploy_user}` has failed to `#{fetch :slack_deploy_or_rollback}` branch `#{fetch :branch}` of #{fetch :application} to `#{fetch :stage, 'an unknown stage'}`"
}

# set :sidekiq_roles => :worker
# set :sidekiq_default_hooks => true
# set :sidekiq_pid => File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid') # ensure this path exists in production before deploying.
# set :sidekiq_log => File.join(shared_path, 'log', 'sidekiq.log')
#
# SSHKit.config.command_map[:sidekiq] = 'bundle exec sidekiq -r ./domains/workers_init.rb -C ./config/sidekiq.yml'
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, {
  user: 'apps',
  forward_agent: true
}
