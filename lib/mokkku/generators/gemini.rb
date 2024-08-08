require 'gemini-ai'

module Mokkku
  module Generators
    class Gemini
      def self.call(api_key:, prompt:)
        client = ::Gemini.new(
          credentials: {
            service: 'generative-language-api',
            api_key: api_key
          },
          options: { model: 'gemini-pro', server_sent_events: false }
        )

        result = client.generate_content({
          contents: { role: 'user', parts: { text: prompt } }
        })

        result['candidates'].first['content']['parts'].first['text']
      end
    end
  end
end
