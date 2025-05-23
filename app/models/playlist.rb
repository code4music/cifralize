# frozen_string_literal: true

class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs, dependent: :destroy
  has_many :songs, through: :playlist_songs
  before_create :set_uuid, if: -> { uuid.nil? }
  before_create :set_default_visibility

  VISIBILITY_OPTIONS = %w[public private unlisted]

  def to_param
    uuid
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def set_default_visibility
    self.visibility ||= 'public'
  end
end
