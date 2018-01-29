# Setting up a new Rails app

### <u>Work in progress</u>

to be added in document further on :



<<<<<<<<<<<<<<<<<<<<<<<<

Install Devise

*.Gemfile*, add

```ruby
gem 'devise'
```

```shell
$ bundle install
```

```shell
$ rails generate devise:install
```

```shell
$ rails generate devise User
$ rails db:migrate
```

*in controllers* for models that have restricted access :

```ruby
before_action :authenticate_user!
```

<<<<<<<<<<<<<<<<<<<<<<<<<<



Rest of document

*Create app newApp*, no testing (-T), postgresql as database, no turbolinks

```shell
$ rails new newApp -T --database=postgresql --skip-turbolinks  
$ cd newApp
$ rails server
>
```

*check* on : http://localhost:3000  -> Yay! You're on Rails! (shows Rails version, Ruby version)

```ruby
> Ctrl+C     to exit
```

(At this point the local git repository is also initiated, no need for `$ git init`)



Make sure there is always a database connection established when entering the Rails console.

*./config/application.rb*, add *console do* to existing code

```ruby
# config/application.rb

module newApp
  class Application < Rails::Application
    # Add next 3 lines
    console do
      ActiveRecord::Base.connection
    end
  end
end

```



*Create database*

```shell
$ rails db:create
Created database 'newApp_development'
Created database 'newApp_test'
```



*Create remote repository on github.com*

https://github.com/GIT_HUB_USERNAME/newApp

*Update local repository, link it to remote repository and update remote repository*

```shell
$ git add . 
$ git commit -m "Created app newApp"
$ git remote add origin git@github.com:GIT_HUB_USERNAME/newApp.git
$ git push origin master
```

***Commit changes regularly***

```shell
$ git add .
$ git commit -m "Meaningfull message"
```

*and push them to remote once in a while*

```shell
$ git push origin master
```

<u>Stumbled up on</u> :  (in another project)

When trying to link local repository to remote, I got the message :

```shell
$ git remote add origin git@github.com:GIT_HUB_USERNAME/otherApp.git
fatal: remote origin already exists.
```

Apparently I had already done something, that made this impossible. 

Solved it by :

```shell
$ git remote set-url origin git@github.com:GIT_HUB_USERNAME/otherApp.git
```



(create links here, something with id="deployment" e.g.)

*Further setup :*

- Set up styling :  below in this guide
- Set up hosting : below in this guide
- Set up deployment : below in this guide 



*Create home page*

```shell
$ rails generate controller Pages home
```

*./apps/controllers/pages_controller.rb* (is generated)

```ruby
class PagesController < ApplicationController
  def home
  end
end
```

*./config/routes.rb*  (is generated?)

```ruby
Rails.application.routes.draw do
  root to: 'pages#home'
end
```

* If Rspec is NOT set up as testing environment.
* Don't know yet how Minitest tests and asserts. Check out later if necessary

*./spec/features/home_page_spec.rb*

```ruby
require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
```



- If Rspec IS set up as testing environment.

*spec/controllers/pages_controller_spec.rb* (is generated)

```ruby
# rspec spec/controllers/pages_controller_spec.rb
require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

end
```
*spec/views/pages/home.html.erb_spec.rb*, generated?

```ruby
# rspec spec/views/pages/home.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "pages/home.html.erb", type: :view do
  it "should return Rails default text" do
    visit root_url
    expect(page).to have_content "Pages#home"
  end
end
```


```shell
$ rspec
```

Unfortunately, this somehow does not work for me :-(   

```
Failure/Error: visit root_url
NoMethodError:
   undefined method `visit' for #<RSpec::ExampleGroups::PagesHomeHtml
```





*Generate models for Header and Line*

```shell
$ rails generate model Artist header_text:string
Running via Spring preloader in process xxx
      invoke  active_record
      create    db/migrate/20180121174927_create_headers.rb
      create    app/models/header.rb
      create    app/models/header.rb
      invoke    rspec
      create      spec/models/header_spec.rb
      invoke      factory_bot
      create        spec/factories/header.rb


$ rails generate model Song line_desc:string
RRunning via Spring preloader in process xxx
      invoke  active_record
      create    db/migrate/20180121175141_create_lines.rb
      create    app/models/line.rb
      invoke    rspec
      create      spec/models/line_spec.rb
      invoke      factory_bot
      create        spec/factories/lines.rb
1
$ rails db:migrate
```



If <u>relation</u> was <u>not defined</u> during model creation, it can be done after through a new migration :

*Define relation after model is created without reference*

```shell
$ rails generate migration AddHeaderToLines header:references
Running via Spring preloader in process 28846
      invoke  active_record
      create    db/migrate/20180120150713_add_header_to_line.rb
$ rails db:migrate
```

If relation pre-existed, this migration will generate an error 

```ruby
PG::DuplicateColumn: Error column "header_id" of relation "line" already exists.
```

 Just delete the migration from ./db/migrate/, content has not been executed.



*Edit ./app/models/header.rb*    (check colons, spaces and positions!)

```ruby
class Header
	has_many :lines, dependent: :destroy
end
```

Edit ./app/models/line.rb*    (check colons, spaces and positions!)

```ruby
class Header
	has_one :header
end
```



*Create seeds in ./db/seeds.rb*, REWRITE THIS

```ruby
Line.destroy_all
Header.destroy_all

# Seed artists, keep values
meatloaf = Artist.create!(name: "MeatLoaf", image_url: "")
redhot   = Artist.create!(name: "Red Hot Chili Peppers", image_url: "")
jay      =  Artist.create!(name: "Screamin'Jay Hawkins", image_url: "")

# Seed songs
Song.create!(title: "Paradise by the Dashboard Light", artist: meatloaf)
Song.create!(title: "Heaven Can Wait", artist: meatloaf)
Song.create!(title: "All Revved Up With No Place To Go", artist: meatloaf)

Song.create!(title: "Californication", artist: redhot)
Song.create!(title: "Under the Bridge", artist: redhot)
Song.create!(title: "Give It Away", artist: redhot)

Song.create!(title: "Californication", artist: jay)
Song.create!(title: "Under the Bridge", artist: jay)
Song.create!(title: "Give It Away", artist: jay)
```



*Run the seed*

```shell
$ rails db:seed
```



*Check in console*, always keep rails console running in a separate terminal

```shell
$ rails console
```

```ruby
> Header.first
> Line.first
> Line.last.header.header_desc
```



------



<u>*Setup styling*</u>

*.Gemfile*

```ruby
# Use Bootstrap for styling
gem 'bootstrap-sass', '~> 3.3.6'

# Use jQuery for easier javascript
gem 'jquery-rails', '~> 4.3.1'
```

```shell
$ spring stop
$ bundle install
```

**!!** *Change extension of ./app/assets/stylesheets/application.css to .scss*

*./app/assets/stylesheets/application.scss*, pull Bootstrap into the app

```css
@import "bootstrap-sprockets";
@import "bootstrap";
```

*./app/assets/javascripts/application.js*, replace content with

```js
// application.js

//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .
```

*Restart rails server*

<u>Stumbled up on</u> :

- Don't forget to change the extension of application.css to .scss




<u>*Set up CarrierWave and Cloudinary*</u>

*.Gemfile*

```ruby
# Set up CarrierWave for image handling
gem 'carrierwave', '0.11.2'

# Set up Cloudinary for cloud storage
gem 'cloudinary', '1.2.3'
```

```shell
$ spring stop
$ bundle install
```

```shell
$ rails generate uploader image
```

*Edit ./apps/uploaders/image_uploader*, make it look like this

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
```

<u>Stumbled up on</u> :

* Don't use names for model attributes that are to generic, like 'Photo.image' for an image_url. When copy-pasting the uploader-attribute connection, it will look like standard syntax, (:image) in stead of trying to point to an actual differently named model attribute (e.g. 'Artist.image_url').
* Rails and Rspec just throw errors at you, but don't know where you went wrong, so can't tell you.
* Naming string to hold image URL in one project 'Photo.image' seriously destroyed my weekend when copy-pasting '*mount_uploader :image, ImageUploader*' from apps/models/Photo.rb to another project. I thought ':image' was part of the uploader syntax.



<u>*Setup Rspec testing*</u>

* default is Minitest

*.Gemfile*

```ruby
# For testing
group :development, :test do
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
end

group :test do
  gem 'capybara', '~> 2.9', '>= 2.9.1'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
end
```

```shell
$ spring stop
$ bundle install
```

*Setup Rspec for application*

```shell
$ spring stop
$ rails generate rspec:install
$ rbenv rehash
$ rails db:migrate
$ rspec
```

*spec/support/factory_bot.rb* (create folder and file)

```ruby
# spec/support/factory_bot.rb

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

```

*spec/rails_helper.rb*, uncomment line

```ruby
# spec/rails_helper.rb

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

```

When using Devise for user authentication :

*spec/support/devise.rb*, create file

```ruby
# spec/support/devise.rb

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Warden::Test::Helpers
end
```





<u>*Setup deployment*</u>

* Heroku is installed on local machine
* $ heroku auth:whoami   =>  YOUR_USER_NAME
* You must always be in the <u>master branch</u> when pushing code to Heroku

*.Gemfile*, top of file :

```ruby
source 'https://rubygems.org'
# Add next line
ruby '2.4.1'
```

*.Gemfile*

```ruby
# For deployment
gem 'rails_12factor', group: :production
```

```shell
$ spring stop
$ bundle install
```

*Set up Heroku app locally*

* Heroku needs an app-name

```shell
$ heroku create new-app
```

App running at   https://new-app.herokuapp.com/ 

<u>Stumbled up on</u> :

- Heroku does not know what to do before you define the app-name for current project.
- Only lowercase characters and dashes in app-name



If Cloudinary is set up ( Cloudinary environment variable is set):

*Config heroku to use content hosting service*

```shell
$ heroku config:set CLOUDINARY_URL=$CLOUDINARY_URL
```




*Create controllers for Artists and Songs*

```shell
$ rails generate controller Headers
$ rails generate controller Lines
```



*./apps/views/pages/home.html.erb*

```html
<div class="row">
  <div class="col-md-6 col-md-offset-3">
    <h1 class="text-center">New App!</h1>
    <div class="col-md-12 text-center">
      Ready for a whole new New App?
    </div>
  </div>
</div>
```

*./config/routes.rb*, setup routing

```ruby
Rails.application.routes.draw do
  get 'pages/home'
  resources :headers
  resources :headers do
    resources :lines
end
```

*Push to github*

*Deploy to heroku*

```shell
$ git add .
$ git commit -m "Gems installed for styling, image uploading and hosting, testing, deployment. Home page set up"
$ git push origin master
$ git push heroku master
```

App on Heroku : https://cfy-zjan.herokuapp.com/

<u>Stumbled up on</u> : 

- Heroku deployment process : Warning: the running version of Bundler (1.15.2) is older than the version that created the lockfile (1.16.1). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
- When generating a new Rails app, one of the messages is `Using bundler 1.16.1`
- What's happening? What is the running version of Bundler?





- [x] Local Home page is up
- [x] Push to github
- [x] Deploy to Heroku
- [x] Heroku Home page is up





*Create Headers Overview Page*

*./apps/models/header.rb*

```
no change
```

*./app/views/headers/index.html.erb*

```erb
      <div class="panel-heading">
        <p><%= @header.header_desc %></p>
      </div>

      <div class="panel-body">
      <% @lines.each do |line| %>
        <div class="col-md-12">
          <p>
            <%= line.line_desc %>
          </p>
        </div>
      <% end %>
      </div>
      <hr>
```

*./apps/controllers/header_controller.rb*

```ruby
  def index
    @headers = Header.all
  end
```



*Create Header Show Page*

*./apps/models/artist.rb*

```
no change
```

*./apps/views/headers/show.html.erb*

```erb
      <div class="panel-heading">
        <p><%= @header.header_desc %></p>
      </div>

      <div class="panel-body">
      <% @lines.each do |line| %>
        <div class="col-md-12">
          <p>
            <%= line.line_desc %>
          </p>
        </div>
      <% end %>
      </div>
```

*./apps/controllers/header_controller.rb*

```ruby
  before_action :set_header, only: %i[show edit update]

  def show
    @lines = @header.lines
  end

private

  def set_header
    @header = Header.find(params[:id])
  end

  def header_params
    params
      .require(:header)
      .permit(:header_desc)
  end

```

