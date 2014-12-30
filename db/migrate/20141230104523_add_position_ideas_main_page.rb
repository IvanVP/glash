class AddPositionIdeasMainPage < ActiveRecord::Migration
  def self.up
    add_column :ideas, :main_position, :integer
  end

  def self.down
    remove_column :ideas, :main_position
  end
end
