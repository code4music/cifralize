class Artist < ApplicationRecord
  has_many :songs, dependent: :destroy
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  before_create :set_uuid, if: -> { uuid.nil? }
  before_validation :generate_slug, on: %i[create update]
  before_create :set_default_visibility

  VISIBILITY_OPTIONS = %w[public private unlisted]

  def to_param
    uuid
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_slug
    self.slug = name.parameterize if name.present? && name_changed?
  end

  def set_default_visibility
    self.visibility ||= 'public'
  end
end
