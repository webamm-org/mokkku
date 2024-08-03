require_relative '../spec_helper'

RSpec.describe Mokkku::Generators::Gpt do
  describe '.call' do
    it 'calls Open AI API' do
      client = instance_double(OpenAI::Client, completions: double)
      api_key = 'api_key'
      prompt = 'prompt'

      expect(OpenAI::Client)
        .to receive(:new)
        .with(access_token: api_key)
        .and_return(client)

      expect(client)
        .to receive(:completions)
        .with(parameters: {
          prompt: prompt,
          model: 'gpt-3.5-turbo-instruct',
          temperature: 0,
          max_tokens: 1_000,
          top_p: 1.0,
          frequency_penalty: 0.0,
          presence_penalty: 0.0
        })
        .and_return('choices' => [{ 'text' => 'mock' }])

      expect(
        described_class.call(api_key: api_key, prompt: prompt)
      ).to eq('mock')
    end
  end
end
