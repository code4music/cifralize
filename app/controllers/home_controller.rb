# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @top_songs = Song.where(visibility: 'public').order(views_count: :desc).limit(15)
    @top_playlists = Playlist.where(visibility: 'public').order(views_count: :desc).limit(15)
  end

  def search
    query = params[:q].to_s.strip
    @songs = Song.joins(:artist).where(visibility: 'public').where("songs.title ILIKE :q OR artists.name ILIKE :q", q: "%#{query}%").page(params[:page]).per(20)
    @playlists = Playlist.where(visibility: 'public').where('name ILIKE ?', "%#{params[:q]}%").page(params[:page]).per(20)
  end

  def about; end

  def genres
    @genres = Genre.order(name: :asc)
  end

  def genre
    @genre = Genre.find_by!(slug: params[:slug])
    @songs = @genre.songs.where(visibility: 'public').order(title: :asc).page(params[:page]).per(20)
  end

  def artists
    @artists = Artist.order(name: :asc).page(params[:page]).per(20)
  end

  def artist
    @artist = Artist.find_by!(slug: params[:artist])
    @songs = @artist.songs.where(visibility: 'public')
    @top_songs = @songs.order(views_count: :desc).limit(10)
    @songs = @songs.order(title: :asc).page(params[:page]).per(20)
  end

  def songs
    @songs = Song.where(visibility: 'public').order(title: :asc).page(params[:page]).per(20)
  end

  def song
    @song = Song.joins(:artist).find_by(slug: params[:song], artists: { slug: params[:artist] })
    @song.increment!(:views_count)
  end

  def playlists
    @playlists = Playlist.where(visibility: 'public')
  end

  def playlist
    @playlist = Playlist.find_by(uuid: params[:uuid])
    @playlist_songs = @playlist.playlist_songs.includes(:song)
    @playlist.increment!(:views_count)
  end

  def recordings
    @recordings = Recording.where(visibility: 'public').order(created_at: :desc).page(params[:page]).per(20)
  end

  def recording
    @recording = Recording.find_by(uuid: params[:uuid])
    @recording.increment!(:views_count)
    @song = @recording.song if @recording.song
  end

  def tuner; end
end
