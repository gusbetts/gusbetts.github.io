# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'jammit'

Anathief::Application.load_tasks

Jammit.package! :base_url => "https://anagramthief.herokuapp.com/"