class CreateSolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :solutions do |t|
      t.belongs_to :clue, index: true
      t.belongs_to :next_clue, index: true
      t.string :content
      t.timestamps
    end
  end
end
