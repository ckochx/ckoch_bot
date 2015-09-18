require 'spec_helper'
require 'twitter_bot/twitter_bot'

describe TwitterBot::TwitterBot do
  let(:subject) { described_class.new }
  it "#initialize" do
    described_class.new
  end

  it "#connection" do
    expect(subject).to receive(:connection)
    expect(Twitter::REST::Client).to receive(:new)

    subject.connection
  end
end
