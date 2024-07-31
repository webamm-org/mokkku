# Mokkku

Japanese term Mokkku (モック) simply stands for mock. Mokkku is a simple library to provide fake data that is unique for your project. You can easily use LLM like GPT, Gemini, or Claude to fill the mock that based on your database schema. The library is inspired by the FFaker library.

## Configuration

Add gem to the development and test groups in Gemfile:

```ruby
group :development, :test do
  gem 'mokkku'
end
```

As the next step, create initializer in `config/initializers/mokkku.rb`:

```ruby
Mokkku.configure do |config|
  config.mocks_path = './spec/mocks'
end
```

## Usage

Given you have `User` model with the `first_name`, `last_name`, and `location` attributes. Create `spec/mocks/user.yml` file with an array of attributes:

```yaml
- first_name: John
  last_name: Doe
  location: New York
- first_name: Tim
  last_name: Doe
  location: Paris
```

You can now get the test data by calling `Mokkku::User.first_name`, etc. Once you call the class method for the first time, the context is saved and you will get the data from the same record. Calling `Mokkku::User.first_name` will return `John` and then calling `Mokkku::User.location` will return `New York`. If you want to reset the context, call `Mokkku::User.reset_context!`

## Usage with FactoryBot

Remember to reset the context in the after build callback:

```ruby
FactoryBot.define do
  factory :user do
    first_name  { Mokkku::User.first_name }
    last_name   { Mokkku::User.last_name }
    location    { Mokkku::User.location }
  end

  after(:build) { |_| Mokkku::User.reset! }
end
```
