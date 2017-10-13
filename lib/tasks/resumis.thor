require "thor"

ENV['RAILS_ENV'] ||= 'development'
require File.expand_path('config/environment.rb')

class Resumis < Thor
  desc "useradd", "creates a new user"
  def useradd
    say("Let's create your user")
    email = ask('Email: ')
    password = ask('Password: ', :echo => false)
    #Add an empty line
    say('')
    first_name = check_value('First Name: ')
    last_name = check_value('Last Name: ')
    domain = ask('Domain: ')
    subdomain = ask('Subdomain: ')
    admin = yes?('Are you an Admin user? (yes or no)')

    User.create! do |u|
      u.first_name = first_name
      u.last_name = last_name
      u.email = email
      u.password = password
      u.domain = domain
      u.subdomain = subdomain
      u.admin = admin
    end
  end

  no_tasks do
    def check_value(question)
      result = ask(question)
      result != '' ? result : check_value(question)
    end
  end
end
