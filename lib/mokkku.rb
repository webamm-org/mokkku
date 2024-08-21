require_relative 'mokkku/utils'
require_relative 'mokkku/cli/runner'

module Mokkku
  extend Mokkku::Utils

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :mocks_path

    def initialize
      @mocks_path = './spec/mocks'
    end
  end

  # Copied from FFaker gem - https://github.com/ffaker/ffaker
  # Random Number Generator (RNG) used with ModuleUtils#fetch, #shuffle, #rand
  # in order to provide deterministic repeatability.
  module Random
    # Returns the current RNG seed.
    def self.seed
      @seed ||= ::Random.new_seed
    end

    # Sets the RNG seed and creates a new internal RNG.
    def self.seed=(new_seed)
      @seed = new_seed
      reset!
      new_seed
    end

    # Reset the RNG back to its initial state.
    def self.reset!
      @rng = new_rng
    end

    # Returns a random number using an RNG with a known seed.
    def self.rand(max = nil)
      return rng.rand(max) if max

      rng.rand
    end

    # Returns the current Random object.
    def self.rng
      @rng ||= new_rng
    end

    # Returns a new Random object instantiated with #seed.
    def self.new_rng
      ::Random.new(seed)
    end
  end
end
