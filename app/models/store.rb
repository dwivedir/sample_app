class Store < ActiveRecord::Base
  has_many :hash_words
  belongs_to :user

  def self.save(upload)
    file_name = upload['file'].original_filename.downcase
    user_id = upload['user_id']
    directory = "#{Rails.root}/public/data/#{user_id}"
    path = File.join(directory, file_name)
    File.open(path, "wb") do |f|
      f.write(upload['file'].read)
    end
  end

end
