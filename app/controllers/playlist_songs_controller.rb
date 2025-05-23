# frozen_string_literal: true

class PlaylistSongsController < ApplicationController
  before_action :set_playlist_song, only: %i[show edit update destroy]

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

  def update
    playlist_song = PlaylistSong.find(params[:id])
    if playlist_song.update(transpose: params[:playlist_song][:transpose].to_i)
      redirect_to playlist_path(playlist_song.playlist), notice: 'Tom atualizado com sucesso!'
    else
      redirect_to playlist_path(playlist_song.playlist), alert: 'Erro ao atualizar tom.'
    end
  end

  def destroy
    @playlist_song.destroy

    respond_to do |format|
      format.html { redirect_to playlist_songs_url, notice: 'Playlist song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_playlist_song
    @playlist_song = PlaylistSong.find(params[:id])
  end

  def playlist_song_params
    params.require(:playlist_song).permit(:playlist_id, :song_id, :transpose)
  end
end
