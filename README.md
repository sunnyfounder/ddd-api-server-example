# SunnyFounder Api Server
[![CircleCI](https://circleci.com/gh/sunnyfounder/api-server.svg?style=svg&circle-token=59ef1ab152cbc6a9c073755752483259ef0c8017)](https://app.circleci.com/pipelines/github/sunnyfounder)

## 資料夾結構 :open_file_folder:
- domains
  - controllers
  - entities
    - factories
    - adapters
  - repositories
  - usecases
  - services
  - view_objects

- spec
  - domains

- config

- tasks

## 指令 :memo:

### Local
##### 啟動伺服器 `rackup`
##### local 自動重啟伺服器 `rerun rackup`
##### 跑測試 `rspec`
##### 更新 .env.template `dotenv -t .env`
##### 列出所有路徑 `rack routes`
##### 連上ec2 `rake aws:access`
##### 開啟 sidekiq `dotenv bundle exec sidekiq -r ./domains/workers_init.rb -C ./config/sidekiq.yml`

### Deploy
> 可使用 `cap -T` 查看所有 capistrano tasks
##### 上傳 puma config `cap [env] puma:config`
##### restart puma server `cap [env] puma:restart`
##### deploy `bundle exec cap [env] deploy`

### Testing

##### 跑測試 `rspec`

## 注意事項 :warning:
在推到 staging 和 production 上時檢查是否有引用 development 環境才會安裝的套件，e.g. `require 'byebug'`\
在 server 上 puma 啟動失敗時 log 只會顯示 early terminatation of worker, **非常難 debug**
