# Monzo Pennies

### To Deploy

1. Create a pot in Monzo for your roundups (mine's called "Savings").
2. Head over to the [Monzo API Playground](https://developers.monzo.com/api/playground) and get your access token and the `account_id` for your current account.
3. Deploy this app to:

```

```

Set the following environment variables on Heroku:

```shell
heroku config:set MONZOPENNIES_SAVINGS_POT_NAME=Savings # Must match the name in Monzo
heroku config:set MONZOPENNIES_ACCOUNT_ID=XXX # Get this from the API playground
heroku config:set MONZOPENNIES_BASE_URL=XXX # Set this to the deployed URL of your app. eg https://myapp.herokuapp.com
heroku config:set MONZOPENNIES_WEBHOOK_AUTH_TOKEN=XXX # Set this to some random alphanumeric string
heroku config:set MONZO_ACCESS_TOKEN=XXX # Get this from the API Playground
```


### To Run Locally

```shell
brew services start postgres
bundle install
rackup config.ru
```
