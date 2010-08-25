class CanHasPermissionCreateAnonymous< ActiveRecord::Migration
  def self.up
    create_table :anonymous do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_index :anonymous, :name, :unique => true
  end

  def self.down
    add_index :anonymous, :name, :unique => true
    drop_table :anonymous
  end
end