class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :clue, index: true
      t.belongs_to :stackee, index: true
      t.boolean :completed
      t.timestamps
    end
  end
end
