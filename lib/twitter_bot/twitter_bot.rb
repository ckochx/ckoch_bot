require 'twitter'

module TwitterBot
  class TwitterBot

    def hamburgers
      connection.search(q='hamburgers')
    end

    def milkshakes

    end

    def method_name

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

  end
end
