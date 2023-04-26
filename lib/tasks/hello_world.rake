namespace :hello_world do
  desc "これがないとrake -tで表示されないらしい"
  task hello: :environment do
    puts "hello_world"
  end
end