require 'optparse'

namespace :resumis do |t|
  desc "Task for adding a new, active user to Resumis"
  task useradd: :environment do
    # -- is needed to bypass rake, but we need to remove to not mess with OptionParser
    ARGV.delete('--')

    options = {}
    OptionParser.new do |opts|
      opts.banner = 'Usage: rake resumis:useradd -- [options]'
      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
      opts.on('-e', '--email {email}', 'Email Address', String) do |email|
        options[:email] = email
      end
      opts.on('-p', '--password {password}', 'Password', String) do |password|
        options[:password] = password
      end
      opts.on('-f', '--first-name {first name}', 'First Name', String) do |firstname|
        options[:first_name] = firstname
      end
      opts.on('-l', '--last-name {last name}', 'Last Name', String) do |lastname|
        options[:last_name] = lastname
      end
      opts.on('-d', '--domain {domain}', 'Domain', String) do |domain|
        options[:domain] = domain
      end
      opts.on('-s', '--subdomain {subdomain}', 'Subdomain', String) do |subdomain|
        options[:subdomain] = subdomain
      end
    end.parse!

    if Rails.env.test?
      puts "This command only works in development or production."
      puts "Please specify either via RAILS_ENV and call again."
      exit 1
    end

    User.create! do |u|
      u.first_name = options[:first_name]
      u.last_name = options[:last_name]
      u.email = options[:email]
      u.password = options[:password]
      u.domain = options[:domain]
      u.subdomain = options[:subdomain]
    end

    exit 0
  end
end
