class CreateClues < ActiveRecord::Migration[5.0]
  def change
    create_table :clues do |t|
      t.belongs_to :stack, index: true
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
