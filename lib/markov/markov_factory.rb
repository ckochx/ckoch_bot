require 'markovian'

module Markov
  class MarkovFactory
    attr_reader :importer

    def initialize(path='spec/fixtures/text.csv')
      @importer ||= Markovian::Importers::Twitter::CsvImporter.new(path)
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
      corpus.random_word
    end

    private

    def text_builder
      Markovian::TextBuilder.new(corpus)
    end

    def corpus
      @corpus ||= importer.corpus
    end
  end
end