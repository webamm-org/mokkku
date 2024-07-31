module Mokkku
  class MockedObject
    def initialize(mocks)
      @mocks = mocks
      @selected_object = nil
    end

    def reset_context!
      @selected_object = nil
    end

    private

    def mocked_objects
      @mocked_objects ||= @mocks.map do |mock_attrs|
        Data.define(*mock_attrs.keys.map(&:to_sym)).new(**mock_attrs)
      end
    end

    def method_missing(method_name, *args, &block)
      if @selected_object.nil?
        @selected_object = mocked_objects.sample(random: Mokkku::Random)
        @selected_object.public_send(method_name)
      else
        @selected_object.public_send(method_name)
      end
    end
  end
end
