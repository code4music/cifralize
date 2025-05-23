# frozen_string_literal: true

require 'application_system_test_case'

class PlaylistSongsTest < ApplicationSystemTestCase
  setup do
    @playlist_song = playlist_songs(:one)
  end

  test 'visiting the index' do
    visit playlist_songs_url
    assert_selector 'h1', text: 'Playlist songs'
  end

  test 'should create playlist song' do
    visit playlist_songs_url
    click_on 'New playlist song'

    fill_in 'Playlist', with: @playlist_song.playlist_id
    fill_in 'Song', with: @playlist_song.song_id
    fill_in 'Transpose', with: @playlist_song.transpose
    click_on 'Create Playlist song'

    assert_text 'Playlist song was successfully created'
    click_on 'Back'
  end

  test 'should update Playlist song' do
    visit playlist_song_url(@playlist_song)
    click_on 'Edit this playlist song', match: :first

    fill_in 'Playlist', with: @playlist_song.playlist_id
    fill_in 'Song', with: @playlist_song.song_id
    fill_in 'Transpose', with: @playlist_song.transpose
    click_on 'Update Playlist song'

    assert_text 'Playlist song was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Playlist song' do
    visit playlist_song_url(@playlist_song)
    click_on 'Destroy this playlist song', match: :first

    assert_text 'Playlist song was successfully destroyed'
  end
end
