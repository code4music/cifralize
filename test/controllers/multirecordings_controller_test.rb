require "test_helper"

class MultirecordingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multirecording = multirecordings(:one)
  end

  test "should get index" do
    get multirecordings_url
    assert_response :success
  end

  test "should get new" do
    get new_multirecording_url
    assert_response :success
  end

  test "should create multirecording" do
    assert_difference("Multirecording.count") do
      post multirecordings_url, params: { multirecording: { title: @multirecording.title, user_id: @multirecording.user_id } }
    end

    assert_redirected_to multirecording_url(Multirecording.last)
  end

  test "should show multirecording" do
    get multirecording_url(@multirecording)
    assert_response :success
  end

  test "should get edit" do
    get edit_multirecording_url(@multirecording)
    assert_response :success
  end

  test "should update multirecording" do
    patch multirecording_url(@multirecording), params: { multirecording: { title: @multirecording.title, user_id: @multirecording.user_id } }
    assert_redirected_to multirecording_url(@multirecording)
  end

  test "should destroy multirecording" do
    assert_difference("Multirecording.count", -1) do
      delete multirecording_url(@multirecording)
    end

    assert_redirected_to multirecordings_url
  end
end
