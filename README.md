### Installation Requirements 
* ruby v 2.7.2 +
* rails 6.1.0 +
* postgresql database
* yarn

### Connected services required
* AWS S3 - file storage ** in production **
* Google oauth
* Github oauth
* Twitter oauth
* Stripe

### Installing RoR

```
rvm install ruby-2.7.2
rvm --default use 2.7.2
gem install rails -v 6.0.3
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install postgresql libpq-dev redis-server redis-tools yarn
```

### postgresql setup

```
sudo su postgres
createuser --interactive
ubuntu
y 
exit
```

### Run the app in development

1. Create app
```
git clone https://github.com/corsego/saas
cd saas
bundle
yarn

```
2. IMPORTANT Set up your secret credentials, otherwise you will not be able to run the app:

Go to **config** folder and delete the file `credentials.yml.enc`
```
EDITOR=vim rails credentials:edit
```
and inside the file:
```
aws:
  access_key_id: YOUR_CODE
  secret_access_key: YOUR_CODE

github:
  development:
    id: YOUR_CODE
    secret: YOUR_CODE
  production:
    id: YOUR_CODE
    secret: YOUR_CODE

google:
  id: YOUR_CODE
  secret: YOUR_CODE

development:
  stripe:
    publishable: YOUR_CODE
    secret: YOUR_CODE

production:
  stripe:
    publishable: YOUR_CODE
    secret: YOUR_CODE

twitter:
   id: YOUR_CODE
   secret: YOUR_CODE
```
* `i` = to make the file editable
* :set paste = to disable autoindentation when pasting
* `Ctrl` + `V` = to paste
* `ESC` + `:`` + `w` + `q` + `Enter` = save changes in the file

3. Run the migrations 
```
rails db:create
rails db:migrate
```
To add default data, you can also run 
```
rails db:seed
```
4. Add an admin role to the first user added via seeds:
```
rails c
User.first.update(superadmin: true)
```
Now you can access the superadmin views!

5. Start the server
```
rails s
```
6. Log in with email: `admin@example.com`, password: `admin@example.com`

### Run the app in production
```
heroku create
heroku rename *your-app-name*
heroku git:remote -a *your-app-name*
heroku buildpacks:set heroku/ruby
heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview
heroku addons:create sendgrid:starter
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
git push heroku master
heroku run rails db:migrate
```
