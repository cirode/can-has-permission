$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'active_record'
require 'can_has_permission'
require 'rubygems'
require 'ruby-debug'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

def reset_database
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
  ActiveRecord::Schema.define(:version => 1) do
    create_table :roles do |t|
      t.string :name, :null => false
      t.timestamps
    end
    
    create_table :permissions do |t|
      t.string :name, :null => false
      t.timestamps
    end
    
    create_table :has_roles do |t|
      t.string :model, :null => false
      t.integer :model_id, :null => false
      t.integer :role_id, :null => false
      t.timestamps
    end
    create_table :has_permissions do |t|
      t.string :model, :null => false
      t.integer :model_id, :null => false
      t.integer :permission_id, :null => false
      t.timestamps
    end
  end
end

Spec::Runner.configure do |config|
  config.before(:each) do
    reset_database
  end
end
