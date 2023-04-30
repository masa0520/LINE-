#class LineBot
#  #def send_message
#  #  client = Line::Bot::Client.new do |config|
#  #    config.channel_secret = ENV['LINE_CHANNEL_SECRET']
#  #    config.channel_token = ENV['LINE_CHANNEL_TOKEN']
#  #  end
#  #
#  #  message = {
#  #    type: 'text',
#  #    text: 'hello world'
#  #  }
#  #
#  #  response = client.broadcast(message)
#  #end
#  
#  def hoge
#    puts "hello"
#  end
#end

class Batch::Hoge
  def self.hoge
    puts "Hoge!"
  end
end