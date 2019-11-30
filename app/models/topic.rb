class Topic < ApplicationRecord
  belongs_to :user
  # 直接SQLを引数として与える:desc
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title,   presence: true
end
