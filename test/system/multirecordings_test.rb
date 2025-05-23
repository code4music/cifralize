require "application_system_test_case"

class MultirecordingsTest < ApplicationSystemTestCase
  setup do
    @multirecording = multirecordings(:one)
  end

  test "visiting the index" do
    visit multirecordings_url
    assert_selector "h1", text: "Multirecordings"
  end

  test "should create multirecording" do
    visit multirecordings_url
    click_on "New multirecording"

    fill_in "Title", with: @multirecording.title
    fill_in "User", with: @multirecording.user_id
    click_on "Create Multirecording"

    assert_text "Multirecording was successfully created"
    click_on "Back"
  end

  test "should update Multirecording" do
    visit multirecording_url(@multirecording)
    click_on "Edit this multirecording", match: :first

    fill_in "Title", with: @multirecording.title
    fill_in "User", with: @multirecording.user_id
    click_on "Update Multirecording"

    assert_text "Multirecording was successfully updated"
    click_on "Back"
  end

  test "should destroy Multirecording" do
    visit multirecording_url(@multirecording)
    click_on "Destroy this multirecording", match: :first

    assert_text "Multirecording was successfully destroyed"
  end
end
