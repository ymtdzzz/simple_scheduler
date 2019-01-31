class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  accepts_nested_attributes_for :group_users
  validates :name, presence: true, length: { maximum: 30 }

  # グループの作成者を返す
  def owner
    User.find_by(id: self.owner_id)
  end
end
