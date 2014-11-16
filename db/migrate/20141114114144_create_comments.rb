class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer    :user_id
      t.references :commentable, polymorphic: true
      t.text       :body,   :limit => 2500
      t.timestamps
      t.datetime   :moderated_at
      t.integer    :moderator_id
    end
    add_index :comments, [:commentable_id, :commentable_type]

    add_column :ideas, :moderator_id, :integer
    add_column :ideas, :comments_count, :integer, :null => false, :default => 0
  end

  def self.down
    drop_table :comments

    remove_column :ideas, :moderator_id
    remove_column :ideas, :comments_count
  end
end
