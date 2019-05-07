require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'Start our app console'
task :console do
    Pry.start
end

desc 'Create a new user'
task :createuser do
    CreateUserCLI.run
end

desc 'Find a new user'
task :finduser do
    FindUserCLI.run
end
