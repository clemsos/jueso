class AddDataToUsers < ActiveRecord::Migration
  
    def self.up
      add_column :users, :city, :string
      add_column :users, :weibo, :string
      add_column :users, :alias, :string
    end

    def self.down
      remove_column :users, :city
      remove_column :users, :weibo
      remove_column :users, :alias
    end

end
