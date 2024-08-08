require_relative 'gpt'
require_relative 'claude'
require_relative 'gemini'

module Mokkku
  module Generators
    class Builder
      UnsupportedGenerator = Class.new(StandardError)

      def self.call(generator:, api_key:, prompt:)
        case generator
        when 'gpt'
          Mokkku::Generators::Gpt
        when 'claude'
          Mokkku::Generators::Claude
        when 'gemini'
          Mokkku::Generators::Gemini
        else
          raise UnsupportedGenerator
        end
      end
    end
  end
end
