module Mokkku
  class YamlSanitizer
    def self.sanitize(yaml_content)
      # Some LLMs ignore the instructions and return YAML with additions
      yaml_lines = yaml_content.split("\n")
      yaml_lines.shift if yaml_lines.first.start_with?("`")
      yaml_lines.pop if yaml_lines.last.start_with?("`")
      yaml_lines.shift unless yaml_lines.first.strip.start_with?('-')

      yaml_lines.join("\n")
    end
  end
end
