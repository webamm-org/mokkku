require_relative '../spec_helper'

RSpec.describe Mokkku::Cli::Runner do
  describe '.start' do
    it 'generates mocks for provided models' do
      options = {
        models: ['TestUser'],
        llm_model: 'gpt',
        llm_api_key: 'api_key'
      }

      prompt = 'test prompt'

      expect(Mokkku::Cli::Validator)
        .to receive(:validate_options!)
        .with(options)
        .once
      expect(Mokkku::Cli::Prompt)
        .to receive(:generate)
        .with('TestUser', ['column1', 'column2'], 10, 'english')
        .and_return(prompt)
      expect(Mokkku::Generators::Builder)
        .to receive(:call)
        .with(generator: 'gpt', api_key: 'api_key', prompt: prompt)
        .and_return(Mokkku::Generators::Gpt)
      expect(Mokkku::Generators::Gpt)
        .to receive(:call)
        .with(api_key: 'api_key', prompt: prompt)
        .and_return('mocks')

      expect(File)
        .to receive(:write)
        .with('./spec/mocks/test_user.yml', 'mocks')
        .once

      described_class.start(options)
    end
  end

  class TestUser
    def self.columns
      ['column1', 'column2']
    end
  end
end
