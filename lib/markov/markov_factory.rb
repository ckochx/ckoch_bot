require 'markovian'

module Markov
  class MarkovFactory
    attr_reader :importer

    def initialize(path='spec/fixtures/text.csv')
      @importer ||= Markovian::Importers::Tweeter::CsvImporter.new(path)
    end

    def short_tweet
      loop do
        this_tweet = tweet
        return this_tweet if tweet.length <= 130
      end
    end

    def tweet
      text_builder.construct(random_word)
    end

    def random_word
      chain.random_word
    end

    private

    def text_builder
      Markovian::TextBuilder.new(chain)
    end

    def chain
      @chain ||= importer.chain
    end
  end
end
