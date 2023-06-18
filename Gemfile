source('https://rubygems.org')

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem('active_model_serializers')
gem('bcrypt', '~> 3.1.7')
gem('bootsnap')
gem('jwt', '~> 2.1.0')
gem('postgresql')
gem('puma', '~> 5.6.4')
gem('rack-attack')
gem('rack-cors')
gem('rails', '~> 7.0.4', '>= 7.0.4.3')
gem('rubocop')
gem('will_paginate', '~> 3.3')

group :development, :test do
  gem('byebug', platforms: %i[mri mingw x64_mingw])
  gem('database_cleaner')
  gem('factory_bot_rails')
  gem('faker')
  gem('rspec-rails')
  gem('simple_command', '~> 0.1.0')
end

group :development do
  gem('listen', '~> 3.8.0')
  gem('spring')
  gem('spring-watcher-listen', '~> 2.0.0')
  gem('web-console', '~> 3.7.0')
end

group :test do
  gem('database_cleaner')
  gem('rspec')
  gem('rspec-mocks')
  gem('shoulda-matchers', '~> 4.4.0')
end

gem('tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby])
