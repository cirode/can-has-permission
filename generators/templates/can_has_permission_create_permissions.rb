class CanHasPermissionCreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permission do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_index :permission, :name, :unique => true
  end

  def self.down
    remove_index :permission, :name
    drop_table :permission
  end
end
