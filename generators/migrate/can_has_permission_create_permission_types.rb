class CanHasPermissionCreatePermissionTypes < ActiveRecord::Migration
  def self.up
    create_table :permission_types do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_index :permission_types, :name, :unique => true
  end

  def self.down
    remove_index :permission_types, :name
    drop_table :permission_types
  end
end
