### generate model
```
# example
$ rails generate model SensorData sensor_id:integer value:float lat:float long:float user_id:integer timestamp:datetime
```

### migration
```
$ rake db:migrate
```

### generate controller
```
# example
rails generate controller YOUR_CONTROLLER_NAME
```

### manual cron
```
# example (local)
$ rails runner Tasks::Hoge.execute
# example (heroku)
$ heroku run rails runner Tasks::Hoge.execute
```

### automatical cron
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

### create app on Heroku
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

### deploy Heroku
```
$ git push heroku master
$ heroku run rake db:migrate
$ bundle exec heroku open
```
