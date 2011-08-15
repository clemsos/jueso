class AddRelatedToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :ref, :string
    add_column :microposts, :ref_id, :integer
  end

  def self.down
    remove_column :microposts, :ref
    remove_column :microposts, :ref_id
  end
end
