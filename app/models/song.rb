# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :genre, optional: true
  has_many :recordings, dependent: :destroy
  validates :title, presence: true
  before_create :set_uuid, if: -> { uuid.nil? }
  before_validation :generate_slug, on: %i[create update]
  before_create :set_default_visibility

  VISIBILITY_OPTIONS = %w[public private unlisted]

  include PgSearch::Model
  
  pg_search_scope :search_by_title_chords_and_artist,
    against: [:title, :chords],
    associated_against: {
      artist: [:name]
    },
    using: {
      tsearch: {
        prefix: true,
        dictionary: "portuguese"
      },
      trigram: {
        threshold: 0.2
      }
    }

  def to_param
    uuid
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_slug
    self.slug = title.parameterize if title.present? && title_changed?
  end

  def set_default_visibility
    self.visibility ||= 'public'
  end
end
