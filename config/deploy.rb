# frozen_string_literal: true

set :repo_url, 'https://github.com/pulibrary/allsearch_api.git'
set :application, 'allsearch_api'

set :branch, ENV['BRANCH'] || 'main'

set :deploy_to, -> { "/opt/#{fetch(:application)}" }
set :repo_path, -> { "/opt/#{fetch(:application)}/repo" }

set :log_level, :debug

set :ssh_options, { forward_agent: true }

set :linked_dirs, %w[log]

namespace :passenger do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'passenger-config restart-app /opt/allsearch_api/current'
    end
  end
end

after 'deploy:publishing', 'passenger:restart'
