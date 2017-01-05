class Stackee < User
  belongs_to :stack
  has_many :stackers, through: :stack
  def new
    super
    self.type = 'Stackee'
  end
end
