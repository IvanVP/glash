class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table(:contacts) do |t|
      t.integer  :user_id,           null: false
      t.string   :phone
      t.string   :phone2
      t.string   :skype,              limit: 50
      t.boolean  :show_skype,         default: false
      t.string   :site
      t.boolean  :show_site,          default: false              
      t.string   :vkontakte 
      t.string   :facebook       
      t.string   :odnoklassniki
      t.string   :twitter
      t.string   :linkedin

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
