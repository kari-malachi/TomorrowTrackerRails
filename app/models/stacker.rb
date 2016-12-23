class Stacker < StackUser
  has_many :stackees, through: :stack
  def new
    super
    self.type = 'Stacker'
  end
end
