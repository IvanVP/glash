class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  has_attached_file :data,
                    :styles => { :thumb => "150x150>", :large => "800x450>" },
                    :default_url => "/images/:style/missing.png"


  # validates_attachment :data, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment :data, :presence => true,
                          :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] },
                          :size => { :in => 0..3.megabytes }

  def url(*args)
    data.url(*args)
  end
  
  def name
    data_file_name
  end
  
  def content_type
    data_content_type
  end
  
  def file_size
    data_file_size
  end
end
