class AddUserIdToProjects < ActiveRecord::Migration
  
  def self.up
    change_table :projects do |t|
      t.integer :user_id, :null => false, :options =>
      "CONSTRAINT fk_project_users REFERENCES users(id)"
    end
  end

  def self.down
    remove_column :projects, :user_id
  end
end