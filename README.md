# Monzo Pennies

### To Deploy

1. Create a pot in Monzo for your roundups (mine's called "Savings").
2. Head over to the [Monzo API Playground](https://developers.monzo.com/api/playground) and get your access token and the `account_id` for your current account.
3. Deploy this app to:

```shell
heroku create
git push heroku master
heroku addons:create heroku-postgresql:hobby-dev
heroku addons:create scheduler:standard
heroku run rake db:migrate
heroku config:set MONZOPENNIES_BASE_URL=$(heroku apps:info -s  | grep web_url | cut -d= -f2)
```

Now the following environment variables on Heroku:

```shell
heroku config:set MONZOPENNIES_SAVINGS_POT_NAME=Savings # Must match the name in Monzo
heroku config:set MONZOPENNIES_ACCOUNT_ID=XXX # Get this from the API playground
heroku config:set MONZOPENNIES_WEBHOOK_AUTH_TOKEN=XXX # Set this to some random alphanumeric string
heroku config:set MONZO_ACCESS_TOKEN=XXX # Get this from the API Playground
```

Now run the rake task to create the webhook:

```shell
heroku ps:restart
heroku run rake create_webhooks
```

Finally, run `heroku addons:open scheduler` and set up a job to run at whatever time you prefer. The job should run the following command:

```shell
rake save_pennies
```

![Image of Heroku Job](http://c.danny.is/pvLK/Screen%20Shot%202018-03-05%20at%2000.31.41.png)

---

### To Run Locally

```shell
brew services start postgres
bundle install
rackup config.ru
```
