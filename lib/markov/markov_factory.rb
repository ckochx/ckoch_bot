require 'markovian'

module Markov
  class MarkovFactory
    attr_reader :importer

    def initialize(path='spec/fixtures/tweets.csv')
      @importer ||= Markovian::Importers::Twitter::CsvImporter.new(path)
    end

    def tweet
      text_builder.construct(random_word)
    end

    private

    def text_builder
      Markovian::TextBuilder.new(corpus)
    end

    def corpus
      @corpus ||= importer.corpus
    end

    def random_word
      corpus.random_word
    end
  end
end