class Clue < ApplicationRecord
  belongs_to :stack

  has_many :solutions, dependent: :destroy
  has_many :next_clues, through: :solutions,
                        source: :next_clue
  has_many :previous_solutions, class_name: 'Solution',
                                foreign_key: 'next_clue_id'
  has_many :previous_clues, through: :previous_solutions,
                            source: :clue

  has_many :assignments, dependent: :destroy
  has_many :stackees, through: :assignments

  validates :title, presence: true
  validates :content, presence: true

  def self.all_in_stack(this_stack)
    self.where(stack_id: this_stack).all
  end
end
