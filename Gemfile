source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'       # db
gem "thin"          # Server
gem "rabl"          # For sending JSON
gem "oj"            # For sending JSON
gem "jquery-rails"

# Bootstrap data in the application so you don't have to fetch right away.
gem "gon"

# Exposes rails url helpers as a global Routes object that you can use on frontend.
# rake routes in terminal shows all the routes available for your server, this
# lets you see the same routes on the front end through the Routes object.
gem "js-routes"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'modernizr-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem "eco"
  gem "compass-rails"
  gem 'foundation-rails'   # Foundation 5.0
  gem "foundation-icons-sass-rails"

  # gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                                # :github => 'anjlab/bootstrap-rails'
  # gem "font-awesome-sass-rails"
  # gem "bootstrap-sass-rails"
  # gem "zurb-foundation"  # Foundation 4.0

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rails-dev-tweaks'
  gem 'better_errors'
end
