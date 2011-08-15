class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      
      t.string :title
      t.text :description
      t.integer :user_id
      
      t.timestamps
    end
      add_index :galleries, :user_id
  end

  def self.down
    drop_table :galleries
  end
end
