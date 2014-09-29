class AddsUsersRoleCounrtyEnabled < ActiveRecord::Migration
  def self.up
    add_column :users, :role_id, :integer, after: :email
    add_column :users, :country_id, :integer, after: :email
    add_column :users, :enabled, :boolean, default: true, after: :email
  end

   def self.down
     remove_column :users, :role_id
     remove_column :users, :country_id
     remove_column :users, :enabled
   end
end
