class CanHasPermissionCreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.string :permissible_type, :null => false
      t.integer :permissible_id, :null => false
      t.integer :permission_type_id, :null => false
      t.timestamps
    end
    add_index :permissions, :permission_type_id
    add_index :permissions, [:permissible_id, :permissible_type]
  end

  def self.down
    remove_index :permissions, :permission_type_id
    remove_index :permissions, [:permissible_id, :permissible_type]
    drop_table :permissions
  end
end
