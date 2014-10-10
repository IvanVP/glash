class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string  :fname,              limit: 30
      t.string  :mname,              limit: 70
      t.string  :lname,              limit: 50
      t.string  :name,               limit: 50
      t.string  :email,              null: false, default: ""
      t.string  :slug,               null: false
      t.date    :birthdate 
      t.boolean :show_birthdate,     default: true
      t.string  :gender,             limit: 1 
      t.boolean :show_gender,        default: true
      t.text    :description
      t.boolean :enabled,            default: true
      t.integer :role_id
      t.integer :country_id
      t.timestamps
      
      t.boolean :terms,             default: false
      t.string :encrypted_password, null: false, default: ""

      ## Trackable
      t.integer  :sign_in_count,     default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      
    end

    add_index :users, :name,                 unique: true
    add_index :users, :email,                unique: true
    add_index :users, :slug,                 unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true

    # add_index :users, :unlock_token,         unique: true
  end

  def self.down
    drop_table :users
  end
end
