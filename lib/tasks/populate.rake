require 'twitter_bot/twitter_bot'
require 'markov/markov_factory'

namespace :speech_bot do
  desc "This task (twitter_bot:search_cheeseburger) is called by the Heroku scheduler add-on"
  task :search_cheeseburger => :environment do
    # Only Run on odd hour
    puts "Hour is: #{Time.now.hour}"
    if (Time.now.hour%2 == 1)
      puts "Beginning cheeseburger tweet-back."
      TwitterBot::TwitterBot.new.tweet_back('cheeseburger', 3)
      puts "done."
    end
  end

  desc "This task (twitter_bot:search_milkshake) is called by the Heroku scheduler add-on"
  task :search_milkshake => :environment do
    puts "Hour is: #{Time.now.hour}"
    if (Time.now.hour%2 == 0)
      puts "Beginning milkshake tweet-back."
      TwitterBot::TwitterBot.new.tweet_back('milkshake', 3)
      puts "done."
    end
  end

  desc "populate notes with tweet coach speeches"
  task :tweet => :environment do
    puts "Beginning markov tweets."
    puts "&"*77
    markov_factory = Markov::MarkovFactory.new('spec/fixtures/speeches.csv')

    10.times do
      tweet = markov_factory.tweet
      puts tweet
    end
  end
end
