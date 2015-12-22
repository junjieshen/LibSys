class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :ISBN
      t.text :title
      t.text :description
      t.text :authors
      t.text :status

      t.timestamps null: false
    end
    add_index :books, :ISBN, unique: true
  end
end
