class CreateProptoprojs < ActiveRecord::Migration
  def self.up
    create_table :proptoprojs do |t|
      t.integer :proposal_id
      t.integer :project_id
      
      t.timestamps
    end
    
    add_index :proptoprojs, :proposal_id
    add_index :proptoprojs, :project_id
    add_index :proptoprojs, [:project_id, :proposal_id], :unique => true
    
  end

  def self.down
    drop_table :proptoprojs
  end
end
