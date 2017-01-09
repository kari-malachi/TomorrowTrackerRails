class Solution < ApplicationRecord
  belongs_to :clue
  belongs_to :next_clue, class_name: 'Clue'
  validates :content, presence: true
end
