# frozen_string_literal: true

require 'application_system_test_case'

class PlaylistsTest < ApplicationSystemTestCase
  setup do
    @playlist = playlists(:one)
  end

  test 'visiting the index' do
    visit playlists_url
    assert_selector 'h1', text: 'Playlists'
  end

  test 'should create playlist' do
    visit playlists_url
    click_on 'New playlist'

    fill_in 'Name', with: @playlist.name
    click_on 'Create Playlist'

    assert_text 'Playlist was successfully created'
    click_on 'Back'
  end

  test 'should update Playlist' do
    visit playlist_url(@playlist)
    click_on 'Edit this playlist', match: :first

    fill_in 'Name', with: @playlist.name
    click_on 'Update Playlist'

    assert_text 'Playlist was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Playlist' do
    visit playlist_url(@playlist)
    click_on 'Destroy this playlist', match: :first

    assert_text 'Playlist was successfully destroyed'
  end
end
