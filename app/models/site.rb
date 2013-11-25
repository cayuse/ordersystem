class Site < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :sitetype
  has_many :weeklydfcorders
  has_many :weeklyorderreqs, :through=>:weeklydfcorders
  has_many :items, :through=>:weeklyorderreqs
  
  has_many :storelocs
  has_many :itemlocs, :through => :storelocs
  
  has_many :monthlysitems
  has_many :monthlyitems, :through => :monthlysitems, :source=> "item"
  
  before_validation :fix_phone, :fix_state

  validates_uniqueness_of :number, :name
  validates_presence_of :number, :address, :city, :sitetype
  validates_format_of :state, :with=>/^[A-Z][A-Z]/
  validates_length_of :state, :is => 2, :message => "is two Letters only e.g. CA"
  validates_length_of :zip, :is => 5, :message => "is 5 digits only"
  validates_length_of :phone, :is => 10, :message => "is 10 digits with area code"
  validates_numericality_of :phone, :zip
  
  def <=> (other)
    number <=> other.number
  end
  
  private
  
  def fix_phone
    phone.gsub!(/\D/,"")
  end
  
  def fix_state
    state.gsub!(/[a-z,A-Z]+/,"#{state.upcase}")
  end

end
