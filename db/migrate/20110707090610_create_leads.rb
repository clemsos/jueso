class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.string :title
      t.integer :project_id
      
      t.timestamps
    end
    
    add_index :leads, :project_id
  end

  def self.down
    drop_table :leads
  end
end
