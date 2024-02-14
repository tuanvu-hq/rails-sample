class Tag < ApplicationRecord
  has_many :note_tags, dependent: :destroy
  has_many :notes, through: :note_tags

  validates :title, presence: true, length: { in: 2..30 }
end
