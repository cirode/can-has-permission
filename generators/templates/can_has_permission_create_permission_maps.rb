class CanHasPermissionCreatePermissionMaps < ActiveRecord::Migration
  def self.up
    create_table :permission_maps do |t|
      t.string :permissible_type, :null => false
      t.integer :permissible_id, :null => false
      t.integer :permission_id, :null => false
      t.timestamps
    end
    add_index :permission_maps, :permission_id
    add_index :permission_maps, [:permissible_id, :permissible_type]
  end

  def self.down
    remove_index :permission_maps, :permission_id
    remove_index :permission_maps, [:permissible_id, :permissible_type]
    drop_table :permission_maps
  end
end
