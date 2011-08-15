class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.string :title
      t.text :description
      t.text :rewards
      t.text :more
      t.integer :money
      t.integer :user_id

      t.timestamps
    end
    
    add_index :proposals, :user_id
    add_index :proposals, :created_at
    add_index :proposals, :money
        
  end

  def self.down
    drop_table :proposals
  end
end
