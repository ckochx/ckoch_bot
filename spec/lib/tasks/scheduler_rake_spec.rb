require 'spec_helper'
require 'rake'

RSpec.describe "twitter_bot" do
  let(:twitter_bot_double) { double("twitter_bot", tweet_back: true) }
  let(:markov_double) { double("markov", tweet: true) }

  before do
    Rake.application.rake_require "tasks/scheduler"
    Rake::Task.define_task(:environment)
  end

  it "#search_cheeseburger calls twitter bot on odd hours" do
    # Timecop.freeze(Time.local(2015, 9, 1, 13, 5, 10))
    if Time.now.hour%2 == 1
      expect(TwitterBot::TwitterBot).to receive(:new).and_return(twitter_bot_double)
      expect(twitter_bot_double).to receive(:tweet_back).with("cheeseburger", 3)
    else
      expect(TwitterBot::TwitterBot).to_not receive(:new)
    end
    Rake::Task["twitter_bot:search_cheeseburger"].invoke
  end

  it "#markov_tweet only runs every 3 hours" do
    if Time.now.hour%3 == 0
      expect(Markov::MarkovFactory).to receive(:new).and_return(markov_double)
      expect(markov_double).to receive(:tweet)
      expect(TwitterBot::TwitterBot).to receive(:new).and_return(twitter_bot_double)
      expect(twitter_bot_double).to receive(:tweet).with(anything)
    else
      expect(Markov::MarkovFactory).to_not receive(:new)
    end

    Rake::Task["twitter_bot:markov_tweet"].invoke
  end

  it "#search_milkshake calls twitter bot on even hours" do
    if Time.now.hour%2 == 0
      expect(TwitterBot::TwitterBot).to receive(:new).and_return(twitter_bot_double)
      expect(twitter_bot_double).to receive(:tweet_back).with("milkshake", 3)
    else
      expect(TwitterBot::TwitterBot).to_not receive(:new)
    end
    Rake::Task["twitter_bot:search_milkshake"].invoke
  end
end
