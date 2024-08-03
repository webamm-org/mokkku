require 'openai'

module Mokkku
  module Generators
    class Gpt
      def self.call(api_key:, prompt:)
        client = OpenAI::Client.new(access_token: api_key)

        response = client.completions(parameters: {
          prompt: prompt,
          model: 'gpt-3.5-turbo-instruct',
          temperature: 0,
          max_tokens: 1_000,
          top_p: 1.0,
          frequency_penalty: 0.0,
          presence_penalty: 0.0
        })

        response['choices'].first['text']
      end
    end
  end
end
