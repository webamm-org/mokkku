require_relative 'gpt'
require_relative 'claude'

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
        else
          raise UnsupportedGenerator
        end
      end
    end
  end
end
