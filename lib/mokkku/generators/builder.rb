require_relative 'gpt'

module Mokkku
  module Generators
    class Builder
      UnsupportedGenerator = Class.new(StandardError)

      def self.call(generator:, api_key:, prompt:)
        case generator
        when 'gpt'
          Mokkku::Generators::Gpt
        else
          raise UnsupportedGenerator
        end
      end
    end
  end
end
