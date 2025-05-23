# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :registerable
  belongs_to :role
  has_many :songs, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :recordings, dependent: :destroy

  before_create :set_uuid, if: -> { uuid.nil? }
  before_validation :generate_slug, on: %i[create update]

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_slug
    self.slug = title.parameterize if title.present? && title_changed?
  end
end
