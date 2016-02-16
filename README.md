# vasp_project


## Server

local: http://localhost:3000

dev: https://vasp.herokuapp.com


## Cheat sheet

### Generate model
```
$ rails generate model Hoge fuga_id:integer foo:float bar:float timestamp:datetime
```

### Migration
```
$ rake db:migrate
```

### Generate controller
```
# example
rails generate controller YOUR_CONTROLLER_NAME
```

### Manual cron
```
# example (local)
$ rails runner Tasks::Hoge.execute
# example (heroku)
$ heroku run rails runner Tasks::Hoge.execute
```

### Automatic cron
```
# example (local)
# register
$ bundle exec whenever --update-crontab
# delete
$ bundle exec whenever --clear-crontab
$
# example (heroku)
# create scheduler
$ heroku addons:create scheduler:standard
# test scheduler
$ heroku run rake update_feed
# set scheduler
$ heroku addons:open scheduler
```

### Create app on Heroku
```
$ bundle exec heroku create YOUR_APP
```

### PostgreSQL setting
```
$ heroku addons:add heroku-postgresql --app YOUR_APP
$ heroku config --app YOUR_APP
=== herokuapp Config Vars
DATABASE_URL:                  postgres://〜
HEROKU_POSTGRESQL_(COLOR)_URL: postgres://〜
....
$ heroku pg:promote HEROKU_POSTGRESQL_(COLOR)_URL --app YOUR_APP
```

### Deploy Heroku
```
$ git push heroku master
$ heroku run rake db:migrate
$ bundle exec heroku open
```

### Test
```
$ bundle exec rake test
```
