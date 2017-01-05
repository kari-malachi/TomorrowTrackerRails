class Stacker < User
  belongs_to :stack
  has_many :stackees, through: :stack
  def new
    super
    self.type = 'Stacker'
  end
end
