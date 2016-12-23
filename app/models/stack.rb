class Stack < ApplicationRecord
  has_many :stackers
  has_many :stackees

  validates :name, presence: true,
            uniqueness: true
end
