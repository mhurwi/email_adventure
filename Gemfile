source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.2'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass', '>= 3.0.0.0'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'mongoid', :github=>"mongoid/mongoid"
gem 'rolify'
gem 'sendgrid'
gem 'simple_form'
gem 'griddler'
gem 'active_attr'
gem 'rack-cors', :require => 'rack/cors'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'spork-rails', :github => 'sporkrb/spork-rails'
  gem 'guard-spork'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem "letter_opener"
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'pry-nav'
end
group :production do
  gem 'thin'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'mongoid-rspec', '>= 1.6.0', :github=>"evansagge/mongoid-rspec"
end
