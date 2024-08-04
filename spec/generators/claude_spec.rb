require_relative '../spec_helper'

RSpec.describe Mokkku::Generators::Claude do
  describe '.call' do
    it 'calls Anthropic API' do
      client = instance_double(Anthropic::Client, messages: double)
      api_key = 'api_key'
      prompt = 'prompt'

      expect(Anthropic::Client)
        .to receive(:new)
        .with(access_token: api_key)
        .and_return(client)

      expect(client)
        .to receive(:messages)
        .with(
          parameters: {
            model: 'claude-3-5-sonnet-20240620',
            system: 'Respond only with code.',
            messages: [
              { 'role': 'user', 'content': prompt },
            ],
            max_tokens: 1_000
          }
        )
        .and_return('content' => [{ 'text' => 'mock' }])

      expect(
        described_class.call(api_key: api_key, prompt: prompt)
      ).to eq('mock')
    end
  end
end
