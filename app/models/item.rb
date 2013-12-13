class Item < ActiveRecord::Base

  define_index do
    indexes name
  end
      #set_property :delta => true


  belongs_to :itemtype
  has_many :prices, :dependent => :destroy, :order=>'start'
  has_many :sitemizations
  has_many :sitetypes, :through => :sitemizations
  has_many :orderitems
  has_many :weeklydfcorders, :through => :orderitems
  has_many :monthlyinvitems
  has_many :monthlyinvs, :through => :monthlyinvitems
  has_many :monthlysitems
  has_many :monthlysites, :through => :monthlysitems, :source=> "site"
  has_many :itemallergens
  has_many :allergens, :through => :itemallergens

  validates_presence_of :itemtype
  validates_uniqueness_of :name

  attr_accessor :test

  after_save :save_sitetype_collections

    def for_type(type)
      find(:all, :conditions=> {:sitetype => type})
    end

  def update_price(price)
    if Time.now - self.current_price.created_at < 10
      return
    end
    oldprice = self.current_price
    newprice = self.prices.build
    newprice.price = price[:price]
    newprice.cost  = price[:cost]
    newprice.fmv   = price[:fmv]
    newprice.start = price[:start]
    oldprice.expire = newprice.start

    if oldprice.save && newprice.save
      return newprice
    else
      return nil
    end
  end

  def <=> (other)
    sort <=> other.sort
  end

  def previous
    Item.find(:last, :order => "sort",  :conditions => ["sort < ?", sort])
  end

  def next
    Item.find(:first, :order=>:sort,  :conditions => ["sort > ?", sort])
  end

  def current_price
    Price.find_by_item_id(self, :order=>'start DESC')
  end

  def todays_price
    price_on_date(Date.today)
  end

  def price_on_date(date)
    prices = self.prices.sort
    return prices.last if prices.last.start <= date
    price = Price.find_by_item_id(self, :conditions=>["start <= ? and expire > ?", date, date])
    return price if price
    prices.last
  end

  def expired?
    return self.current_price.expire ? true : false
  end

#  def self.search(search, page)
#    paginate :per_page => 100, :page => page,
#             :conditions => ['name like ?', "%#{search}%"],
##             :include => :prices,
#             :order => :sort
#  end

  def sitetype_ids=(sitetype_ids)
    @new_sitetype_ids = sitetype_ids
  end

  def save_sitetype_collections
    if @new_sitetype_ids
      sitemizations.each do |sitemization|
        sitemization.destroy unless @new_sitetype_ids.include? sitemization.sitetype_id
      end

      @new_sitetype_ids.each do |id|
        self.sitemizations.create(:sitetype_id => id) unless sitemizations.any? { |d| d.sitetype_id == id }
      end
    end
  end

end
