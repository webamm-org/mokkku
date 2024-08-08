require 'spec_helper'

RSpec.describe Mokkku::Generators::Gemini do
  describe '.call' do
    it 'calls Google API' do
      generated_content = {
        'candidates' => [
          { 'content' => { 'parts' => [{ 'text' => 'text' }] } }
        ]
      }
      client = instance_double(::Gemini::Controllers::Client, generate_content: generated_content)
      expect(::Gemini)
        .to receive(:new)
        .with(
          credentials: { service: 'generative-language-api', api_key: 'api_key' },
          options: { model: 'gemini-pro', server_sent_events: false }
        )
        .and_return(client)
      expect(client)
        .to receive(:generate_content)
        .with({contents: { role: 'user', parts: { text: 'prompt' } }})
        .and_return(generated_content)

      described_class.call(api_key: 'api_key', prompt: 'prompt')
    end
  end
end
