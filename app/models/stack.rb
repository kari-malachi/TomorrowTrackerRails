class Stack < ApplicationRecord
  has_many :stackers, dependent: :nullify
  has_many :stackees, dependent: :nullify
  has_many :clues, dependent: :destroy

  validates :name, presence: true,
            uniqueness: true
end
