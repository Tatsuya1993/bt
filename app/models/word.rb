class Word < ApplicationRecord
  has_many :user
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
  scope :initial_search, -> search_key { where(search_key: search_key) }
  
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
