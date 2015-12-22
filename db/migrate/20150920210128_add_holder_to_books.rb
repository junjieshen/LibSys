class AddHolderToBooks < ActiveRecord::Migration
  def change
    add_column :books, :holder, :string
  end
end
