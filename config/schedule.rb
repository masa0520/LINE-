# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#set :output, 'log/cron.log'
#env :PATH, ENV['PATH']

require File.expand_path(File.dirname(__FILE__) + '/environment')
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"
#set :runner_command, "rails runner"
# bundler versionmismatchを防ぐ
#job_type :rake, "source $HOME/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
job_type :runner, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rails runner ':task' :output"
# rakeタスク内で日本語を扱う場合(?)、これがないと`encoding::UndefinedConversionError`が発生する
env 'LANG', 'ja_JP.UTF-8'

set :runner_command, "rails runner"

every 1.minutes do
  runner "LineBot::LineMessage.send_message(current_user.id)"
end 

#every 1.minutes do
#  rake "hello_world:hello"
#end

#every 1.day, at: time do
#  runner "LineBot::LineMessage.send_message"
#end


#users = User.all
#users.each do |user|
#  user.posts.each do |post|
#    time = post.set_time.strftime("%I:%M %p")
#  
#    every 1.day, at: time do
#      runner "LineBot::LineMessage.send_message"
#    end
#  end
#end




