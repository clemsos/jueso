class AddStatesToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.text :state
    end
  end

  def self.down
    remove_column :projects, :state
  end
end