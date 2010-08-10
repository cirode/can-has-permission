class CreateHasPermissions < ActiveRecord::Migration
  def self.up
    create_table :has_permissions do |t|
      t.string :model, :null => false
      t.integer :model_id, :null => false
      t.integer :permission_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :has_permissions
  end
end
