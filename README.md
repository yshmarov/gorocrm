###### Saas - row-based multitenancy boilerplate.

### Installation Requirements 
* ruby v 2.7.1 +
* rails 6.0.3 +
* postgresql database
* yarn

### Connected services required
* AWS S3 - file storage ** in production **
* Google oauth (development & production)
* Github oauth (development & production)

### Installing RoR

```
rvm install ruby-2.7.1
rvm --default use 2.7.1
rvm uninstall 2.6.3
gem install rails -v 6.0.3
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install postgresql libpq-dev redis-server redis-tools yarn
```

# postgresql setup

```
sudo su postgres
createuser --interactive
ubuntu
y 
exit
```

### Installation the app

1. Create app
```
git clone https://github.com/yshmarov/saas
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
  secret_access_key: Br/YOUR_CODE

github:
  development:
    id: YOUR_CODE
    secret: YOUR_CODE
  production:
    id: YOUR_CODE
    secret: YOUR_CODE

google:
  id: 12352653799-YOUR_CODE
  secret: YOUR_CODE

```
* i = to make the file editable
* :set paste = to disable autoindentation when pasting
* Ctrl + V = to paste
* ESC + : + w + q + Enter = save changes in the file

3. Run the migrations 
```
rails db:create
rails db:migrate
```
You can also run 
```
rails db:seed
```
That will provide some minimal sample data

4. Configure your development environment in config/environments/development.rb (if needed)
6. Start the server
```
rails s
```

### For production environments
```
heroku create
heroku rename *your-app-name*
heroku git:remote -a *your-app-name*
heroku buildpacks:set heroku/ruby
heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview
git push heroku master
heroku run rake db:migrate
heroku addons:create sendgrid:starter
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
```

### Give a user superadmin rights (only through the console)
```
rails c
User.first.update(superadmin: true)
```


If you have troubles running the app or any questions don't hesitate to contact me at hello@corsego.com 🧐 