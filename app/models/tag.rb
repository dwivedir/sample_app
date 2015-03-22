class Tag < ActiveRecord::Base
  has_and_belongs_to_many :stores
  validates :name, length: {maximum: 5}
end
