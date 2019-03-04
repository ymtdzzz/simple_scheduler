class Task < ApplicationRecord
  attr_accessor :url
  has_many :task_users, dependent: :destroy
  has_many :users, through: :task_users, dependent: :destroy
  accepts_nested_attributes_for :task_users, allow_destroy: true
  # belongs_to :user
  # validates :user_id, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :memo, length: { maximum: 140 }

  # 予定の作成者を返す
  def owner
    User.find_by(id: self.owner_id)
  end
end
