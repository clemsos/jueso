class CreateChangeRoles < ActiveRecord::Migration
  def self.up
    create_table :change_roles do |t|
      t.string :real_name
      t.string :state
      t.text :description
      t.text :more
      t.integer :phone
      t.string :role
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :change_roles
  end
end
