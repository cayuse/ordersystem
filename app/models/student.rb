class Student < ActiveRecord::Base
  validates_uniqueness_of :number
  has_many :studentallergens
  has_many :allergens, :through => :studentallergens
end
