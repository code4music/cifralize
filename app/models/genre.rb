class Genre < ApplicationRecord
  has_many :songs
  before_create :set_uuid, if: -> { uuid.nil? }
  before_validation :generate_slug, on: %i[create update]

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
end
