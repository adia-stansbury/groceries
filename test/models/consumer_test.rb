require 'test_helper'

class ConsumerTest < ActiveSupport::TestCase
  setup do
    @consumer = consumers(:adia)
  end

  test "strips user input" do
    @consumer.update(name: ' name ')

    assert_equal('name', @consumer.name)
  end
end
