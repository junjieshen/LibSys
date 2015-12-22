class ChangeActionToStatusInHistory < ActiveRecord::Migration
  def up
    rename_column :histories, :action, :status 
  end
  
  def down
  end
end
