class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :book_id
      t.string :member_email
      t.string :action

      t.timestamps null: false
    end
  end
end
