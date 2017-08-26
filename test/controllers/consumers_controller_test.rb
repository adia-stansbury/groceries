require 'test_helper'

class ConsumersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consumer = consumers(:adia)
  end

  test "should get index" do
    get consumers_url
    assert_response :success
  end

  test "should show consumer" do
    get consumer_url(@consumer)
    assert_response :success
  end
end
