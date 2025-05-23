require "test_helper"

class RecordingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recording = recordings(:one)
  end

  test "should get index" do
    get recordings_url
    assert_response :success
  end

  test "should get new" do
    get new_recording_url
    assert_response :success
  end

  test "should create recording" do
    assert_difference("Recording.count") do
      post recordings_url, params: { recording: { description: @recording.description, likes_count: @recording.likes_count, title: @recording.title, views_count: @recording.views_count, visibility: @recording.visibility } }
    end

    assert_redirected_to recording_url(Recording.last)
  end

  test "should show recording" do
    get recording_url(@recording)
    assert_response :success
  end

  test "should get edit" do
    get edit_recording_url(@recording)
    assert_response :success
  end

  test "should update recording" do
    patch recording_url(@recording), params: { recording: { description: @recording.description, likes_count: @recording.likes_count, title: @recording.title, views_count: @recording.views_count, visibility: @recording.visibility } }
    assert_redirected_to recording_url(@recording)
  end

  test "should destroy recording" do
    assert_difference("Recording.count", -1) do
      delete recording_url(@recording)
    end

    assert_redirected_to recordings_url
  end
end
