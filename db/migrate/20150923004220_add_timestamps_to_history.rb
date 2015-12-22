class AddTimestampsToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :checkout_at, :datetime
    add_column :histories, :return_at, :datetime
  end
end
