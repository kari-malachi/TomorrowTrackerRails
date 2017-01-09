class Stackee < User
  belongs_to :stack, optional: true
  has_many :stackers, through: :stack
  
  has_many :assignments, dependent: :destroy
  has_many :clues, through: :assignments

  def new
    super
    self.type = 'Stackee'
  end
end
