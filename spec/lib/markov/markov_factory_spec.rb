require 'markov/markov_factory'

RSpec.describe Markov::MarkovFactory do
  let(:path) { 'spec/fixtures/test_tweets.csv' }
  let(:subject) { described_class.new(path) }

  it "builds a Markov CSV importer" do
    expect(Markovian::Importers::Twitter::CsvImporter).to receive(:new).with(path).and_call_original

    subject
  end

  it "creates a Markovian TextBuilder" do
    expect(Markovian::TextBuilder).to receive(:new).with(anything).and_call_original

    tweet = subject.tweet
  end

  it "returns a tweet" do
    25.times do
      expect(subject.tweet.length).to be <140
    end
  end

  context "path argument" do
    it "takes an optional path argument" do
      expect(Markovian::Importers::Twitter::CsvImporter).to receive(:new).with('spec/fixtures/tweets.csv').and_call_original

      described_class.new('spec/fixtures/tweets.csv')
    end
  end
end