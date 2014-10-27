class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :order
      t.string :name, limit: 80

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
