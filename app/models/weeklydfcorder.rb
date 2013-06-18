class Weeklydfcorder < ActiveRecord::Base

  belongs_to :site
  belongs_to :weeklyorderreq
  has_many :orderitems, :dependent => :destroy
  has_many :items, :through => :orderitems
  after_update :save_orderitems

  validates_uniqueness_of :weeklyorderreq_id, :scope => :site_id


  def <=> (other)
    site.name <=> other.site.name
  end

  def existing_orderitem_attributes=(orderitem_attributes)
    orderitems.reject(&:new_record?).each do |orderitem|
     orderitem.attributes = orderitem_attributes[orderitem.id.to_s]
      if (orderitem.attributes and (orderitem.attributes["monqty"].to_i + orderitem.attributes["tueqty"].to_i + orderitem.attributes["wedqty"].to_i + orderitem.attributes["thuqty"].to_i + orderitem.attributes["friqty"].to_i) > 0)
        orderitem = orderitem.attributes
      else
        orderitems.destroy(orderitem)
      end
    end
  end

  def new_orderitem_attributes=(orderitem_attributes)
    orderitem_attributes.each do |attributes|
      if (attributes["monqty"].to_i + attributes["tueqty"].to_i + attributes["wedqty"].to_i + attributes["thuqty"].to_i + attributes["friqty"].to_i) > 0
        orderitems.build(attributes)
      end
    end
  end

  def save_orderitems
    orderitems.each do |t|
      if t.allqty > 0
        t.save(false)
      end
    end
  end

  def unused_items
    weekly = Array.new
    usedids = self.orderitems.collect{|t| t.item_id}
    if usedids.empty?
      oids = [0]
    else
      oids = usedids
    end
    items = Item.find_all_by_itemtype_id(Weeklyorderreq::VALID_ITEM_TYPES,
                                :include=>:sitetypes,
                                :order => :sort,
                                :conditions=>["sitemizations.sitetype_id = ? AND items.id NOT IN (?)",
                                self.site.sitetype.id, oids])
    items.each do |i|
      if !(i.current_price.expire and self.weeklyorderreq.week > i.current_price.expire)
        weekly.push(Orderitem.new(:attributes=>
                                  {:item_id=>i.id, :weeklydfcorder_id=>self.id,
                                    :monqty=>0,
                                    :tueqty=>0,
                                    :wedqty=>0,
                                    :thuqty=>0,
                                    :friqty=>0}))
      end
    end

    return weekly
  end


end
