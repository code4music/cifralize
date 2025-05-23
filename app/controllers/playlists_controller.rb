# frozen_string_literal: true

class PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[show edit update destroy]

  def index
    if current_user.role == Role.admin
      @playlists = Playlist.all
    else
      @playlists = current_user.playlists
    end
  end

  def show
    @playlist_songs = @playlist.playlist_songs.includes(:song)
  end

  def new
    @playlist = Playlist.new
  end

  def edit; end

  def create
    @playlist = current_user.playlists.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to playlists_path, notice: 'Lista criada com sucesso.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to playlists_path, notice: 'Lista atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Lista excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_playlist
    @playlist = Playlist.find_by(uuid: params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :description, :visibility, :verified)
  end
end
