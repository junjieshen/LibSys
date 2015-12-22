class ChangeIsbnIntLimit < ActiveRecord::Migration
  def change
    change_column :books, :ISBN, 'bigint USING CAST(ISBN AS bigint)'
  end
end
