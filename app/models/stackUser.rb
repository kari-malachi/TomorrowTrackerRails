class StackUser < User
  belongs_to :stack

  def self.find_all_in_stack(stackId)
    self.where('stack_id = ' + stackId).all
  end
end
