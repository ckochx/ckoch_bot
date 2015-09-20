require 'spec_helper'
require 'rake'
require 'timecop'

RSpec.describe "twitter_bot" do
  let(:twitter_bot_double) { double("twitter_bot", tweet_back: true) }
  let(:markov_double) { double("markov", tweet: true) }

  before do
    Rake.application.rake_require "tasks/scheduler"
    Rake::Task.define_task(:environment)
  end


  context "even_time" do
    it "#search_cheeseburger only runs on odd hours" do
      Timecop.freeze(Time.local(2015, 9, 1, 12, 5, 10))
      expect(TwitterBot::TwitterBot).to_not receive(:new)

      Rake::Task["twitter_bot:search_cheeseburger"].invoke
      Timecop.return
    end

    it "#markov_tweet calls twitter bot" do
      Timecop.freeze(Time.local(2015, 9, 1, 12, 5, 10))
      expect(Markov::MarkovFactory).to receive(:new).and_return(markov_double)
      expect(markov_double).to receive(:tweet)

      Rake::Task["twitter_bot:markov_tweet"].invoke
      Timecop.return
    end
  end

  context "odd_time" do
    it "#search_cheeseburger calls twitter bot when it runs" do
      Timecop.freeze(Time.local(2015, 9, 1, 13, 5, 10))
      expect(TwitterBot::TwitterBot).to receive(:new).and_return(twitter_bot_double)
      expect(twitter_bot_double).to receive(:tweet_back).with("cheeseburger", 3)

      Rake::Task["twitter_bot:search_cheeseburger"].invoke
      Timecop.return
    end

    it "#markov_tweet only runs every 3 hours" do
      Timecop.freeze(Time.local(2015, 9, 1, 13, 5, 10))
      expect(Markov::MarkovFactory).to_not receive(:new)

      Rake::Task["twitter_bot:markov_tweet"].invoke
      Timecop.return
    end
  end

  context "search_milkshake" do
    it "calls twitter bot" do
      expect(TwitterBot::TwitterBot).to receive(:new).and_return(twitter_bot_double)
      expect(twitter_bot_double).to receive(:tweet_back).with("milkshake", 3)

      Rake::Task["twitter_bot:search_milkshake"].invoke
    end

    it "only runs on even hours (when configured)"
  end

end
