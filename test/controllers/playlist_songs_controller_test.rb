# frozen_string_literal: true

require 'test_helper'

class PlaylistSongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @playlist_song = playlist_songs(:one)
  end

  test 'should get index' do
    get playlist_songs_url
    assert_response :success
  end

  test 'should get new' do
    get new_playlist_song_url
    assert_response :success
  end

  test 'should create playlist_song' do
    assert_difference('PlaylistSong.count') do
      post playlist_songs_url,
           params: { playlist_song: { playlist_id: @playlist_song.playlist_id, song_id: @playlist_song.song_id,
                                      transpose: @playlist_song.transpose } }
    end

    assert_redirected_to playlist_song_url(PlaylistSong.last)
  end

  test 'should show playlist_song' do
    get playlist_song_url(@playlist_song)
    assert_response :success
  end

  test 'should get edit' do
    get edit_playlist_song_url(@playlist_song)
    assert_response :success
  end

  test 'should update playlist_song' do
    patch playlist_song_url(@playlist_song),
          params: { playlist_song: { playlist_id: @playlist_song.playlist_id, song_id: @playlist_song.song_id,
                                     transpose: @playlist_song.transpose } }
    assert_redirected_to playlist_song_url(@playlist_song)
  end

  test 'should destroy playlist_song' do
    assert_difference('PlaylistSong.count', -1) do
      delete playlist_song_url(@playlist_song)
    end

    assert_redirected_to playlist_songs_url
  end
end
