require 'spec_helper'
require 'twitter_bot/twitter_bot'

describe TwitterBot::TwitterBot do
  let(:twitter_double) { Twitter::REST::Client.new }
  let(:subject) { described_class.new }

  it "#initialize" do
    described_class.new
  end

  it "#connection" do
    expect(Twitter::REST::Client).to receive(:new)

    subject.send(:connection)
  end

  context "twitter_double" do
    before do
      allow(Twitter::REST::Client).to receive(:new).and_return(twitter_double)
    end

    it "hamburgers" do
      expect(twitter_double).to receive(:search).with(q='hamburgers')

      subject.hamburgers
    end
  end
end
