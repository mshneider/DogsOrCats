class CreateGuesses < ActiveRecord::Migration[5.0]
  def change
    create_table :guesses do |t|
      t.integer :height
      t.integer :weight
      t.string :likes
      t.boolean :confirmed

      t.timestamps
    end
  end
end
