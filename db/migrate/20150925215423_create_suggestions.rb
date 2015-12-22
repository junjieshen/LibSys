class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :member_email
      t.integer :book_ISBN
      t.string :book_title
      t.string :book_description
      t.string :book_authors
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
