class Word < ApplicationRecord
  has_many :user
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
