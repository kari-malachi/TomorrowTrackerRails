class Stackee < StackUser
  has_many :stackers, through: :stack
  def new
    super
    self.type = 'Stackee'
  end
end
