class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.belongs_to :stack, index: true
      t.string :name
      t.string :username
      t.string :encrypted_password
      t.string :salt
      t.string :type
      t.timestamps
    end
  end
end
