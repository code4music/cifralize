# frozen_string_literal: true

class PlaylistSongsController < ApplicationController
  before_action :set_playlist
  before_action :set_playlist_song, only: %i[edit update move_up move_down transpose destroy]

  def create
    playlist_id = params[:playlist_id]
    song_id = params[:song_id]
    transpose = params[:transpose].to_i

    playlist_song = PlaylistSong.find_or_initialize_by(playlist_id:, song_id:)
    playlist_song.transpose = transpose
    if playlist_song.save
      redirect_to home_song_path(playlist_song.song.artist.slug, playlist_song.song.slug, transpose:), notice: 'Música adicionada à lista com sucesso.'
    else
      redirect_back fallback_location: song_path(song_id), alert: 'Erro ao adicionar música.'
    end
  end

  def edit
    @playlist_song.chords = @playlist_song.song.chords if @playlist_song.chords.blank?
    render "playlists/edit_song"
  end

  def update
    @playlist_song.key = params["key"]
    @playlist_song.chords = params["chords"]
    @playlist_song.notes = params["notes"]

    if @playlist_song.save!
      redirect_to home_playlist_path(@playlist), notice: "Música atualizada com sucesso!"
    else
      render :edit
    end
  end

  def transpose
    playlist_song = PlaylistSong.find(params[:id])
    if playlist_song.update(transpose: params[:transpose].to_i)
      redirect_to home_playlist_path(playlist_song.playlist.uuid), notice: 'Tom atualizado com sucesso!'
    else
      redirect_to home_playlist_path(playlist_song.playlist.uuid), notice: 'Erro ao atualizar tom.'
    end
  end

  def destroy
    @playlist_song.destroy

    respond_to do |format|
      format.html { redirect_to playlist_songs_url, notice: 'Playlist song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move_up
    @playlist_song.move_up
    redirect_back fallback_location: root_path
  end

  def move_down
    @playlist_song.move_down
    redirect_back fallback_location: root_path
  end

  private

  def set_playlist
    @playlist = Playlist.find_by(uuid: params[:playlist_id])
  end

  def set_playlist_song
    @playlist_song = @playlist.playlist_songs.find(params[:id])
  end
end
