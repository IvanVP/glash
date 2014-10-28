class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.integer   :user_id
      t.integer   :category_id
      t.string    :title, :limit => 40
      t.string    :synopsis, :limit => 150
      t.text      :problem, :limit => 2500
      t.text      :background, :limit => 2500
      t.text      :solution, :limit => 2500
      t.text      :links, :limit => 1000
      t.boolean   :published, :default => false
      t.boolean   :moderated, :default => false
      t.boolean   :archieved, :default => false
      t.timestamps
      t.datetime   :published_at
      t.datetime   :moderated_at
      t.datetime   :archieved_at
      t.integer    :views, default: 0

    end
  end

  def self.down
    drop_table :ideas
  end
end
