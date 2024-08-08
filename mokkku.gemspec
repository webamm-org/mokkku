lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mokkku/version'

Gem::Specification.new do |s|
  s.add_development_dependency "rspec", '~> 3.7', '>= 3.7.0'
  s.add_development_dependency 'pry'
  s.add_runtime_dependency 'ruby-openai', '~> 7.1.0'
  s.add_runtime_dependency 'anthropic', '~> 0.3.0'
  s.add_runtime_dependency 'gemini-ai', '~> 4.2'
  s.name        = 'mokkku'
  s.version     = Mokkku::Version
  s.date        = '2024-08-01'
  s.summary     = "Generate mock data that is unique for your application"
  s.description = "Generate mock data that is unique for your application"
  s.authors     = ["Paweł Dąbrowski"]
  s.email       = 'contact@paweldabrowski.com'
  s.files       = Dir['lib/**/*.rb', 'spec/helper.rb', 'bin/*']
  s.bindir      = 'bin'
  s.executables = ['mokkku']
end
