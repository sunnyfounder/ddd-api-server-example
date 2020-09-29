# DDD Api Server Example
[![CircleCI](https://circleci.com/gh/sunnyfounder/api-server.svg?style=svg&circle-token=59ef1ab152cbc6a9c073755752483259ef0c8017)](https://app.circleci.com/pipelines/github/sunnyfounder)

## File Structure :open_file_folder:
- domains
  - controllers
  - entities
    - factories
    - adapters
  - repositories
  - workers
  - usecases
  - services
  - view_objects

- spec
  - domains

- config

- tasks

- lib

## instruction :memo:

### Development
##### start server
`rackup`
##### autoreload after starting server
`rerun rackup`
##### update .env.template
`dotenv -t .env`
##### list all existing routes
`rack routes`
##### access aws ec2
`rake aws:access`
##### start sidekiq
`dotenv bundle exec sidekiq -r ./domains/workers_init.rb -C ./config/sidekiq.yml`

### Deploy
##### list all capistrano tasks
`cap -T`
##### upload puma config file
`cap [env] puma:config`
##### restart puma server
`cap [env] puma:restart`
##### deploy
`bundle exec cap [env] deploy`
> add `--dry-run` to simulate all deploy tasks without execute them

### Testing
##### run test
`rspec`

## Warning :warning:
Check the code whether require the gem only installed in development or test or not, e.g. `require byebug`\
It will cause the puma server starting failed, puma access log will only log "early terminatation of worker"\
**DIFFICULT TO DEBUG**
