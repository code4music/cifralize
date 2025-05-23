# frozen_string_literal: true

class SongsController < ApplicationController
  before_action :set_song, only: %i[show edit update destroy]

  def index
    if current_user.role == Role.admin
      @songs = Song.all
    else
      @songs = current_user.songs
    end

    @songs = @songs.order(title: :asc).page(params[:page]).per(20)
  end

  def show
    @transposed_chords = ChordTransposerHelper.transpose(@song.chords, params[:transpose].to_i)
  end

  def new
    @song = Song.new
  end

  def edit; end

  def create
    @song = Song.new(song_params)
    @song.user = current_user if current_user.role != Role.admin

    existing_song = Song.find_by(title: @song.title, artist: @song.artist)
    if existing_song
      respond_to do |format|
        format.html { redirect_to song_url(existing_song.uuid), notice: 'Essa música já existe. Redirecionado para ela.' }
        format.json { render json: { message: 'Já existe', song_url: song_url(existing_song.uuid) }, status: :ok }
      end
      return
    end

    respond_to do |format|
      if @song.save
        format.html { redirect_to song_url(@song.uuid), notice: 'Música adicionada com sucesso.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def cifraclub_scraper
    cifra_url = params[:cifraclub_url]
    cifraclub = CifraclubScraper.pegar_cifra(cifra_url)

    artist = Artist.find_or_create_by(name: cifraclub[:artist])
    genre = Genre.find_or_create_by(name: cifraclub[:genre])

    @song = Song.new
    @song.title = cifraclub[:title]
    @song.artist = artist
    @song.genre = genre
    @song.key = cifraclub[:key]
    @song.cifraclub_url = cifra_url
    @song.from_cifraclub = true
    @song.chords = cifraclub[:cifra]

    render :new
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: 'Música atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Música excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_song
    @song = Song.find_by(uuid: params[:id])
  end

  def song_params
    params.require(:song).permit(:user_id, :title, :artist_id, :genre_id, :key, :chords, :composers, :cifraclub_url, :youtube_url,
                                 :spotify_url, :status, :visibility, :verified)
  end
end
