class Note < ApplicationRecord
  belongs_to :user
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags
  has_many :histories, as: :trackable, dependent: :destroy, autosave: true

  validates :title, presence: true, length: { in: 2..30 }
  validates :description, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 1000 }
end
