class Foodvendor < ActiveRecord::Base
  has_many :nutritionals

    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
