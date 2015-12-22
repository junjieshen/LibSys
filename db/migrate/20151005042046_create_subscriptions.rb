class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :member_email
      t.integer :book_id
      t.boolean :active, default: true
      t.timestamps null: false
    end
  end
end
