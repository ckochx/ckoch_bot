require 'twitter'

module TwitterBot
  class TwitterBot
    CHEESEBURGER_TWEET = "I LOVE cheeseburgers!! 🍔😱😩"
    MILKSHAKE_TWEET = "I LOVE milkshakes!! 😍🍦😋🍨"

    def cheeseburgers
      connection.search('cheeseburger').take(20)
    end

    def milkshakes
      connection.search('milkshake')
    end

    def tweet_back(method='cheeseburgers', tweet_base=CHEESEBURGER_TWEET)
      cb_array = self.send(method).map{ |tw| { username: tw.user.screen_name, id: tw.id, text: tw.text, user_id: tw.user.id } }
      cb_array.sample(5).each do |tw|
        tweet = "@#{tw[:username]} " + tweet_base
        tweet(tweet, tw[:id])
      end
    end

    private

    def connection
      @connection ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['consumer_key']
        config.consumer_secret = ENV['consumer_secret']
        config.access_token = ENV['access_token']
        config.access_token_secret = ENV['access_secret']
      end
    end

    def tweet(tweet, status_id=nil)
      connection.update(tweet, in_reply_to_status_id: status_id)
    end
  end
end
