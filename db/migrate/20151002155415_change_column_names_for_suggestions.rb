class ChangeColumnNamesForSuggestions < ActiveRecord::Migration
  def change
    rename_column :suggestions, :book_ISBN, :ISBN
    rename_column :suggestions, :book_title, :title
    rename_column :suggestions, :book_description, :description
    rename_column :suggestions, :book_authors, :authors
  end
end
