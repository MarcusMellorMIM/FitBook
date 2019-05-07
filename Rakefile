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
