class Assignment < ApplicationRecord
  belongs_to :clue
  belongs_to :stackee

  def new
    super
    self.complete = false
  end
end
