module Mokkku
  module Cli
    class Prompt
      IGNORED_COLUMNS = %w[id created_at updated_at].freeze

      def self.generate(model_name, columns, mocks_count, language)
        columns_for_prompt = columns.reject { |col| IGNORED_COLUMNS.include?(col.name) || col.name.match?(/.*\_id$/) }
                                    .inject({}) { |hash, col| hash[col.name] = col.sql_type_metadata.type; hash }

        prompt_start = "Act like a virtual assistant that generates YAML file with the test data for a given Ruby on Rails model. Generate #{mocks_count.to_i} entries for the following model named #{model_name}:"

        yaml_attributes = columns_for_prompt.map do |name, type|
          "  #{name}: #{type}\n"
        end

        prompt_yaml_part = "- #{yaml_attributes.join}"
        prompt_summary = 'Reply only with the content of the YAML file.'

        if language != 'english'
          prompt_summary += " Translate test data to #{language} language."
        end

        "#{prompt_start}\n\n#{prompt_yaml_part}\n\n#{prompt_summary}"
      end
    end
  end
end
