require 'spec_helper'

RSpec.describe Mokkku::YamlSanitizer do
  describe '.sanitize' do
    it 'removes not needed characters' do
      yaml_content = "```yaml\nusers:\n  - first_name: John\n```"

      expect(described_class.sanitize(yaml_content)).to eq("  - first_name: John")
    end
  end
end
