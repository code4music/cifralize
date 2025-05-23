class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show edit update destroy ]

  def index
    @artists = Artist.order(name: :asc).page(params[:page]).per(20)
  end

  def show; end

  def new
    @artist = Artist.new
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to artist_url(@artist), notice: "Artista adicionado com sucesso." }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to artist_url(@artist), notice: "Artista atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url, notice: "Artista excluído com sucesso." }
      format.json { head :no_content }
    end
  end

  def cifraclub_scraper
    artist_url = params[:cifraclub_url]
    songs_url = CifraclubScraper.get_artist_songs(artist_url)

    skip_keywords = ['/letra/', '/guitarpro/']

    songs_url.each do |url|
      next if skip_keywords.any? { |keyword| url.include?(keyword) }
      ImportCifraclubJob.perform_later(url, current_user.id)
    end
  
    redirect_to root_path, notice: "Importação iniciada. As músicas estão sendo processadas em segundo plano."
  end

  private

  def set_artist
    @artist = Artist.find_by(params[:uuid])
  end

  def artist_params
    params.require(:artist).permit(:name, :visibility)
  end
end
