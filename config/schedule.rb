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
# bundler versionmismatchを防ぐ
#job_type :rake, "source $HOME/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
job_type :runner, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rails runner ':task' :output"
# rakeタスク内で日本語を扱う場合(?)、これがないと`encoding::UndefinedConversionError`が発生する
env 'LANG', 'ja_JP.UTF-8'

User.all.each do |user|
  LinePost.where(user_id: user.id).each do |line_post|
    if line_post.set_time.present?
      every 1.day, at: line_post.set_time.strftime("%I:%M %p") do
        runner "LineBot::LineMessage.send_message"
      end
    end
  end
end
