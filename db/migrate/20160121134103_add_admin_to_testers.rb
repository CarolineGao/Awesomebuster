class AddAdminToTesters < ActiveRecord::Migration
  def change
    add_column :testers, :admin, :boolean, default: false
  end
end
