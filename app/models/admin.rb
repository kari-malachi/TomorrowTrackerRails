class Admin < User
  def new
    super
    self.type = 'Admin'
  end
end
