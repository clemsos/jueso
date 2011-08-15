class AddFieldsToProject < ActiveRecord::Migration
  def self.up
     change_table :projects do |t|
       t.text :rewards
       t.text :morelinks
       t.integer :money
      end
  end

  def self.down
    remove_column :projects, :rewards, :morelinks, :money
  end
end
