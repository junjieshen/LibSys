class AddPreadminToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :preadmin, :boolean, default:false
  end
end
