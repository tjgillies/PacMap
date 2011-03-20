source 'http://gems.rubyforge.org'
gem 'sinatra',       '1.2.1', :require => 'sinatra/base'
gem 'yajl-ruby',     '0.8.1', :require => 'yajl/json_gem'
gem 'typhoeus',      '0.2.4'
gem 'dm-core',       '1.1.0'
gem 'dm-timestamps', '1.1.0'
gem 'dm-migrations', '1.1.0'
gem 'xmpp4r-simple', '0.8.8'
gem 'symboltable',   '1.0.0'
#gem 'rest-client'

group :development do
  gem 'dm-sqlite-adapter', '1.1.0'
  gem 'shotgun',           '0.9',    :require => nil

  platforms :mri_18 do
    gem 'ruby-debug'
  end

  platforms :mri_19 do
    gem 'ruby-debug19', :require => 'ruby-debug'
  end
end

group :test do
  gem 'rack-test', '0.5.7', :require => 'rack/test'
  gem 'contest',   '0.1.2'
end

group :production do
  gem 'dm-postgres-adapter', '1.1.0'
end