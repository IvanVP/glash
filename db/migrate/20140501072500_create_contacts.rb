class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table(:contacts) do |t|
      t.integer  :user_id,           :null => false
      t.string   :phone
      t.string   :phone2
      t.string   :skype,              limit: 50
      t.boolean  :show_skype,         default: true
      t.string   :site
      t.boolean  :show_site,          default: true              
      t.string   :vk_url            
      t.string   :facebook_url       
      t.string   :odnoklassniki_url
      t.string   :twitter_url 
      t.string   :linkedin_url

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
