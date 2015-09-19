require 'spec_helper'
require 'twitter_bot/twitter_bot'

describe TwitterBot::TwitterBot do
  let(:twitter_double) { Twitter::REST::Client.new }
  let(:subject) { described_class.new }
  let(:sample) {
    [
      OpenStruct.new(id: 645306078499090432, text: "@NickGreene_ you're still obligated o ship me a cheeseburger", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
      OpenStruct.new(id: 645306055661080577,
      text:
       "RT @ShopLaGuardia: Not in Terminal B to celebrate #NationalCheeseburgerDay? Check out @TimeOutNewYork's top spots right here in #NYC: http:…", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
      OpenStruct.new(id: 645306021473181696,
      text:
       "RT @plazaatrium: KING DEALS from @BurgerKing_ID @plazaatrium !! Nikmati paket Cheeseburger dan Beefburger hanya Rp 22.727,- http://t.co/VCj…", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
      OpenStruct.new(id: 645305957648592896, text: "RT @SabrinaAnnLynn: Happy national cheeseburger day http://t.co/q75KH7dpVX", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
      OpenStruct.new(id: 645305857396318208, text: "Better be a good cheeseburger. http://t.co/QHJBvc3nla", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
      OpenStruct.new(id: 645305721479950336, text: "RT @WORLDSTAR: Happy National Cheeseburger Day <U+1F354> http://t.co/Lf3DXUWFUK", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
      OpenStruct.new(id: 645305718459924480, text: "@ewcarlos_ I want a cheeseburger more than a nigga and these are #facts", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
      OpenStruct.new(id: 645305657923518465,
      text:
       "RT @funnyordie: Happy #NationalCheeseburgerDay! Enjoy this collection of 11 delicious cheeseburger GIFs: http://t.co/K5BFfiZKrX http://t.co…", user: OpenStruct.new(id: '12345', screen_name: "user_screen_name")),
    ]
  }

  it "#connection" do
    expect(Twitter::REST::Client).to receive(:new)

    subject.send(:connection)
  end

  context "twitter_double" do
    before do
      allow(Twitter::REST::Client).to receive(:new).and_return(twitter_double)
    end

    it "cheeseburgers" do
      expect(twitter_double).to receive(:search).with('cheeseburger').and_return(sample)

      subject.search_tweets('cheeseburger')
    end

    context "with search results" do
      before do
        allow(twitter_double).to receive(:search).and_return(sample)
      end

      it "#tweet_back" do
        expect(twitter_double).to receive(:search).with('cheeseburger')
        expect(twitter_double).to receive(:update).exactly(5).times

        subject.tweet_back('cheeseburger')
      end

      it "includes the user_name in the tweet_back" do
        expect(twitter_double).to receive(:update).with(/@user_screen_name/, anything).exactly(5).times

        subject.tweet_back('cheeseburger')
      end

      it "includes the tweet.id in the tweet_back args" do
        expect(twitter_double).to receive(:update).with(anything, Hash).exactly(5).times

        subject.tweet_back('cheeseburger')
      end

      it "searches milkshakes too" do
        expect(twitter_double).to receive(:search).with('milkshake')
        expect(twitter_double).to receive(:update).exactly(5).times

        subject.tweet_back('milkshake')
      end

      it "tweets back milkshakes" do
        expect(twitter_double).to receive(:update).with(/I LOVE milkshakes!!/ , anything).exactly(5).times

        subject.tweet_back('milkshake')
      end

      it "handles smaller search results" do
        allow(twitter_double).to receive(:search).and_return(sample[0..1])
        expect(twitter_double).to receive(:update).exactly(2).times

        subject.tweet_back
      end

      it "takes a sample size argument" do
        expect(twitter_double).to receive(:update).exactly(3).times

        subject.tweet_back("cheeseburger" ,3)
      end
    end
  end
end

