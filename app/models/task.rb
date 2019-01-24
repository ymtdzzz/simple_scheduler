class Task < ApplicationRecord
  attr_accessor :url
  belongs_to :user
  validates :user_id, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :memo, length: { maximum: 140 }
end
