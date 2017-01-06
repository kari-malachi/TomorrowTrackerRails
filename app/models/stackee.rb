class Stackee < User
  belongs_to :stack, optional: true
  has_many :stackers, through: :stack
  def new
    super
    self.type = 'Stackee'
  end
end
