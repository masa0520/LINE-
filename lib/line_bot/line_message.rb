class LineBot::LineMessage
  def self.send_message
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
    
    User.all.each do |user|
      LinePost.where(user_id: user.id).each do |line_post|
        if line_post.set_time.strftime("%H:%M") == Time.current.strftime("%H:%M")
          view_url = ENV['APP_URL']
          message = {
            type: 'text',
            text: WordMeaning.where(post_id: line_post.post_id).map{|word_meaning|
              "#{word_meaning.word.name} <-> #{word_meaning.meaning.description}"
            }.join("\n") + "\n#{view_url}/#{line_post.post_id}"
          }
          response = client.push_message(user.line_id, message)
        end
      end
    end
  end
end