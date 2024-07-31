require 'yaml'
require_relative 'mocked_object'

module Mokkku
  module Utils
    def const_missing(const_name)
      if const_name.match?(/\:\:/)
        super(const_name)
      else
        mock_file_name = const_name.to_s.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
        mock_path = File.join(Mokkku.configuration.mocks_path, "#{mock_file_name}.yml")
        data = File.read(mock_path)
        parsed_data = YAML.safe_load(data, symbolize_names: true)
        mocked_object = Mokkku::MockedObject.new(parsed_data)

        const_set const_name, mocked_object

        mocked_object
      end
    end
  end
end
