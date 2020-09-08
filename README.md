Run locally:
```
bundle
yarn
rails db:create db:migrate
```
Push to production:
```
heroku create
git push heroku master
heroku run rake db:migrate
heroku addons:create sendgrid:starter
```
Connected services:
* AWS S3 (for tenant logo [production])
* heroku sendgrid (for sending emails [production])
* google recaptcha (no bot sign-ups [development, production])
* 