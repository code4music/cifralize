class Multirecording < ApplicationRecord
  belongs_to :user
  has_many_attached :tracks
end
