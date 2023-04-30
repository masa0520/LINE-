namespace :hello_world do
  desc "これがないとrake -tで表示されないらしい"
  task hello: :environment do
    @post = Post.find_by(id: 3)
    puts @post.inspect
  end
end