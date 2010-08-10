class CreateHasRoles < ActiveRecord::Migration
  def self.up
    create_table :has_roles do |t|
      t.string :model, :null => false
      t.integer :model_id, :null => false
      t.integer :role_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :has_roles
  end
end
