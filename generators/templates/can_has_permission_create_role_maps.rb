class CanHasPermissionCreateRoleMaps < ActiveRecord::Migration
  def self.up
    create_table :role_maps do |t|
      t.string :permissible_type, :null => false
      t.integer :permissible_id, :null => false
      t.integer :role_id, :null => false
      t.timestamps
    end
    add_index :role_maps, :role_id
    add_index :role_maps, [:permissible_id, :permissible_type]
  end

  def self.down
    remove_index :role_maps, :role_id
    remove_index :role_maps, [:permissible_id, :permissible_type]
    drop_table :role_maps
  end
end
