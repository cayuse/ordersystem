class Monthlyinv < ActiveRecord::Base
  belongs_to :site
  belongs_to :monthlyinvreq

  has_many :monthlyinvitems, :dependent => :destroy
  has_many :items, :through => :monthlyinvitems

  after_update :save_monthlyinvitems

  validates_uniqueness_of :monthlyinvreq_id, :scope => :site_id

  def <=> (other)
    site.name <=> other.site.name
  end

  def existing_monthlyinvitem_attributes=(monthlyinvitem_attributes)
    monthlyinvitems.reject(&:new_record?).each do |monthlyinvitem|
      monthlyinvitem.attributes = monthlyinvitem_attributes[monthlyinvitem.id.to_s]
      if (monthlyinvitem.attributes and monthlyinvitem.attributes["qty"].to_f > 0)
        monthlyinvitem = monthlyinvitem.attributes
      else
        monthlyinvitems.destroy(monthlyinvitem)
      end
    end
  end

  def new_monthlyinvitem_attributes=(monthlyinvitem_attributes)
    monthlyinvitem_attributes.each do |attributes|
      if (attributes["qty"].to_f > 0)
        monthlyinvitems.build(attributes)
      end
    end
  end

  def save_monthlyinvitems
    monthlyinvitems.each do |t|
      if t.qty.to_f > 0
        t.save(false)
      end
    end
  end

  def allitems_for_site(site = Setting.current_site)
    date = self.monthlyinvreq.month
    storelocs = site.storelocs.sort
    oldinvitems = self.monthlyinvitems
    inv = {}
    storelocs.each do |loc|
      inv[loc] = []
      loc.itemlocs.sort.each do |item|
        old = oldinvitems.select {|itm| itm.storeloc_id == loc.id && itm.item.id == item.item.id}
        old = old.shift
        if old
          oldinvitems.delete_if {|m| m.id == old.id}
        else
          old = Monthlyinvitem.new :attributes => {:storeloc_id => loc.id, :item_id => item.item.id, :price => item.item.price_on_date(date), :monthlyinv => self}
        end
        inv[loc].push old
      end
    end
    unless oldinvitems.empty?
      inv[:leftovers] = oldinvitems
    end
    return inv
  end

#  def unused_items
#    invs = {}
#    usedids = self.monthlyinvitems.collect{|t| t.item_id}
#    if usedids.empty?
#      oids = [0]
#    else
#      oids = usedids
#    end
#    items = self.site.storelocs.map {|m| m.item}
#    items = Item.find_all_by_itemtype_id(Monthlyinvreq::VALID_ITEM_TYPES,
#                                         :include => :sitetypes,
#                                         :order => :sort,
#                                         :conditions=>["sitemizations.sitetype_id = ? and items.id NOT IN (?)",
#                                         self.site.sitetype.id, oids])
#
#    items.each do |i|
#      if !(i.current_price.expire and self.monthlyinvreq.month > i.current_price.expire)
#        invs[i.itemtype] ||= []
#        invs[i.itemtype].push(Monthlyinvitem.new(:attributes=>
#                {:item_id=>i.id, :monthlyinv_id=>self.id, :qty=>0}))
#      end
#    end
#
#    return invs
#  end


end
