class CreateRewards < ActiveRecord::Migration
  def self.up
    create_table :rewards do |t|
      t.integer :amount_min
      t.integer :amount_max
      t.text :description
      t.integer :project_id, :null => false, :options =>
        "CONSTRAINT fk_reward_projects REFERENCES projects(id)"
        
      t.timestamps
      end
      
      add_index :rewards, :project_id


    
  end

  def self.down
    drop_table :rewards
  end
end
