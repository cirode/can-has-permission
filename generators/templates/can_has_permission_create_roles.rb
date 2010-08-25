class CanHasPermissionCreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :permissible_type, :null => false
      t.integer :permissible_id, :null => false
      t.integer :role_type_id, :null => false
      t.timestamps
    end
    add_index :roles, :role_type_id
    add_index :roles, [:permissible_id, :permissible_type]
  end

  def self.down
    remove_index :roles, :role_type_id
    remove_index :roles, [:permissible_id, :permissible_type]
    drop_table :roles
  end
end
