require 'spec_helper'
require 'rake'

RSpec.describe "twitter_bot:search_cheeseburger" do
  let(:twitter_bot_double) { double("twitter_bot", tweet_back: true) }
  before do
    Rake.application.rake_require "tasks/scheduler"
    Rake::Task.define_task(:environment)
  end

  context "search_cheeseburger" do
    it "calls twitter bot" do
      expect(TwitterBot::TwitterBot).to receive(:new).and_return(twitter_bot_double)
      expect(twitter_bot_double).to receive(:tweet_back).with("cheeseburger", 3)

      Rake::Task["twitter_bot:search_cheeseburger"].invoke
    end
  end

  context "search_milkshake" do
    it "calls twitter bot" do
      expect(TwitterBot::TwitterBot).to receive(:new).and_return(twitter_bot_double)
      expect(twitter_bot_double).to receive(:tweet_back).with("milkshake", 3)

      Rake::Task["twitter_bot:search_milkshake"].invoke
    end
  end
end
