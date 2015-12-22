class ChangeIsbnIntLimitInSuggestions < ActiveRecord::Migration
  def change
    change_column :suggestions, :ISBN, 'bigint USING CAST(ISBN AS bigint)'
  end
end
