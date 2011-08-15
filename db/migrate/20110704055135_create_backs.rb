class CreateBacks < ActiveRecord::Migration
  def self.up
    create_table :backs do |t|
      t.integer :amount
      t.text :comment
      t.integer :user_id
      t.integer :project_id
      
      t.timestamps
    end
    
    add_index :backs, :project_id
    add_index :backs, :user_id
    
  end

  def self.down
    drop_table :rewards
  end
end
