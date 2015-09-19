require 'twitter'

module TwitterBot
  class TwitterBot
    EMOJIS = "😍🍦🍔🍨😋"

    def tweet_back(query='cheeseburger')
      @query = query
      cb_array = search_tweets.map{ |tw| { username: tw.user.screen_name, id: tw.id, text: tw.text, user_id: tw.user.id } }
      cb_array.sample(5).each do |tw|
        tweet = "@#{tw[:username]} " + tweet_text
        tweet(tweet, tw[:id])
      end
    end

    def search_tweets(query=nil)
      current_query = query || @query
      connection.search(current_query).take(25)
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

    def tweet_text
      "I LOVE " + @query + "s!! " + EMOJIS
    end
  end
end
