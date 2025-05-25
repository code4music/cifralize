# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }, path: 'auth'

  get '/', to: 'home#index', as: :home
  get '/search', to: 'home#search', as: :search
  get '/about', to: 'home#about', as: :about
  get '/c/songs', to: 'home#songs', as: :home_songs
  get '/c/artists', to: 'home#artists', as: :home_artists
  get '/c/genres', to: 'home#genres', as: :home_genres
  get '/c/genres/:slug', to: 'home#genre', as: :home_genre
  get '/c/playlists', to: 'home#playlists', as: :home_playlists
  get '/c/playlists/:uuid', to: 'home#playlist', as: :home_playlist
  get '/c/recordings', to: 'home#recordings', as: :home_recordings
  get '/c/recordings/:uuid', to: 'home#recordings', as: :home_recording
  get '/embed/:artist/:song', to: 'embed#show', as: :embed_song
  get '/c/songs/cifraclub', to: 'songs#cifraclub_scraper', as: :cifraclub_song_scraper
  get '/c/artists/cifraclub', to: 'artists#cifraclub_scraper', as: :cifraclub_artist_scraper
  get '/songs/import', to: 'songs#import', as: :songs_import
  get '/tuner', to: 'home#tuner', as: :tuner
  get '/metronome', to: 'home#metronome', as: :metronome
  get 'pads', to: 'home#pads', as: :pads

  resources :artists
  resources :genres
  resources :playlists
  resources :playlist_songs, only: %i[create update destroy]
  resources :songs
  resources :users
  resources :recordings
  resources :multirecordings

  get '/:artist', to: 'home#artist', as: :home_artist
  get '/:artist/:song', to: 'home#song', as: :home_song
end
