require_relative '../spec_helper'

RSpec.describe Mokkku::Cli::Prompt do
  describe '.generate' do
    it 'generates prompt for the model' do
      model_name = 'User'
      columns = [
        Struct.new(:name, :sql_type_metadata).new('first_name', Struct.new(:type).new('string')),
        Struct.new(:name, :sql_type_metadata).new('age', Struct.new(:type).new('integer')),
        Struct.new(:name, :sql_type_metadata).new('favourite_colour', Struct.new(:type).new('string')),
        Struct.new(:name, :sql_type_metadata).new('country', Struct.new(:type).new('string')),
        Struct.new(:name, :sql_type_metadata).new('city', Struct.new(:type).new('string'))
      ]
      mocks_count = 10
      language = 'english'

      expect(
        described_class.generate(model_name, columns, mocks_count, language)
      ).to eq("Act like a virtual assistant that generates YAML file with the test data for a given Ruby on Rails model. Generate 10 entries for the following model named User:\n\n-   first_name: string\n  age: integer\n  favourite_colour: string\n  country: string\n  city: string\n\n\nReply only with the content of the YAML file.")
    end

    it 'generates prompt for the model for custom language' do
      model_name = 'User'
      columns = [
        Struct.new(:name, :sql_type_metadata).new('first_name', Struct.new(:type).new('string')),
        Struct.new(:name, :sql_type_metadata).new('age', Struct.new(:type).new('integer')),
        Struct.new(:name, :sql_type_metadata).new('favourite_colour', Struct.new(:type).new('string')),
        Struct.new(:name, :sql_type_metadata).new('country', Struct.new(:type).new('string')),
        Struct.new(:name, :sql_type_metadata).new('city', Struct.new(:type).new('string'))
      ]
      mocks_count = 10
      language = 'polish'

      expect(
        described_class.generate(model_name, columns, mocks_count, language)
      ).to eq("Act like a virtual assistant that generates YAML file with the test data for a given Ruby on Rails model. Generate 10 entries for the following model named User:\n\n-   first_name: string\n  age: integer\n  favourite_colour: string\n  country: string\n  city: string\n\n\nReply only with the content of the YAML file. Translate test data to polish language.")
    end
  end
end
