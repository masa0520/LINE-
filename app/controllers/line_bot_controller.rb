class LineBotController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery :except => [:callback]

  def callback
    puts "======="
    puts body = request.body.read
    puts "======="

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          #@post = Post.first
          view_url = URI.join(request.url, '/posts/3').to_s
          message = {
            type: "text",
            #text: event.message["text"] + @post.title
            text: "単語学習!\n#{view_url}"
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    end
  end

  private
 
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
