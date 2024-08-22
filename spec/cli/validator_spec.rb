require_relative '../spec_helper'

RSpec.describe Mokkku::Cli::Validator do
  describe '.call' do
    it 'raises error when models are not provided' do
      expect {
        described_class.validate_options!(models: [])
      }.to raise_error(Mokkku::Cli::Validator::ModelsNotProvided)
    end

    it 'raises error when llm model is invalid' do
      expect {
        described_class.validate_options!(models: ['User'], llm_model: 'invalid')
      }.to raise_error(Mokkku::Cli::Validator::InvalidLlmModel)
    end

    it 'raises error when llm api key is not provided' do
      expect {
        described_class.validate_options!(models: ['User'], llm_model: 'gpt', llm_api_key: '')
      }.to raise_error(Mokkku::Cli::Validator::LlmApiKeyNotProvided)
    end

    it 'does not raise error when llm api key and llm model are not provided' do
      expect {
        described_class.validate_options!(models: ['User'])
      }.not_to raise_error
    end
  end
end
