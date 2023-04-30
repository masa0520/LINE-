class LineBot::LineMessage
  def self.send_message(user_id)
      client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
    #if current_user.line_relations.present?
    #  current_user.line_relations.each do |post|
    #    view_url = URI.join(request.url, '/posts/line_relations').to_s
    #    message = {
    #      type: 'text',
    #      text: "単語学習!\n#{view_url}"
    #    }
    #    response = client.broadcast(message)
    #  end
    #end
    user = User.find(user_id)
    @post = Post.first
    view_url = ENV['APP_URL']
    message = {
      type: 'text',
      text: "単語学習!\n#{view_url}" + @post.title + user
    }
    response = client.broadcast(message)
  end
end