class Recording < ApplicationRecord
  belongs_to :user
  belongs_to :song, optional: true
  has_one_attached :audio_file

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
