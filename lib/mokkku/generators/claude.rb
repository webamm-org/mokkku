require 'anthropic'

module Mokkku
  module Generators
    class Claude
      def self.call(api_key:, prompt:)
        client = Anthropic::Client.new(access_token: api_key)

        response = client.messages(
          parameters: {
            model: 'claude-3-5-sonnet-20240620',
            system: 'Respond only with code.',
            messages: [
              { 'role': 'user', 'content': prompt },
            ],
            max_tokens: 1_000
          }
        )

        response['content'].first['text']
      end
    end
  end
end
