require 'twitter_bot/twitter_bot'

namespace :twitter_bot do
  desc "This task is called by the Heroku scheduler add-on"
  task :search_cheeseburger => :environment do
    puts "Beginning cheeseburger tweet-back."
    TwitterBot::TwitterBot.new.tweet_back('cheeseburger')
    puts "done."
  end

  task :search_milkshake => :environment do
    puts "Beginning milkshake tweet-back."
    TwitterBot::TwitterBot.new.tweet_back('milkshake')
    puts "done."
  end
end