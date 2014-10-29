class CreateIdeaImages < ActiveRecord::Migration
  def self.up
    create_table :idea_images do |t|
      t.integer :idea_id
      t.attachment :image

      t.timestamps
    end
  end

  def self.down
    drop_table :idea_images
  end
end
