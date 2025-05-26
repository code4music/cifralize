# frozen_string_literal: true

class PlaylistSong < ApplicationRecord
  belongs_to :playlist
  belongs_to :song

  before_create :set_default_position

  def move_up
    upper_song = playlist.playlist_songs.where("position < ?", position).order(position: :desc).first
    swap_positions(upper_song) if upper_song
  end

  def move_down
    lower_song = playlist.playlist_songs.where("position > ?", position).order(position: :asc).first
    swap_positions(lower_song) if lower_song
  end

  def swap_positions(other)
    PlaylistSong.transaction do
      self.position, other.position = other.position, self.position
      self.save!
      other.save!
    end
  end

  def set_default_position
    max = playlist.playlist_songs.maximum(:position) || 0
    self.position = max + 1
  end
end
