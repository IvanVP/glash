class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :order
      t.string :name, limit: 80

      t.timestamps
    end
  end
end
