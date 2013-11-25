#!/usr/bin/env ruby

require 'ruby-debug'

RAILS_ENV = 'development'
require File.dirname(__FILE__) + '/../config/environment'

#1 STOCK-NUMBER  2 DESCRIPTION 3 PACKAGING 4 LAST-ISS-RCT  5 TYPE  6 CATEGORY  7 USE-CODE
#8 UNIT-OF-ISS 9 FAIR-MKT  10 SURPLUS-AMT 11 DFC-AMT 12 UNIT-FACTOR 13 SERV-FACTOR 14 BID-QTY
#15 STAPLE-ITEM 16 VENDOR-NUMBER 17 LAST-ORD-COST 18 LAST-ORD-QTY  19 YTD-ORD-QTY

#104442,ALL TOASTPANCAKE & WAFFLE ITM,144,0,4,F,Both,CS,15.21,0,15.21,1,0,0, ,0,0,0,0
#104444,BAGELS SWEET BREAD,72,0,4,F,Both,CS,15,0,15,1,0,0, ,0,0,0,0
#104805,20TH CENTRY BAKED BR.BREAD,72,0,4,F,Both,CS,22,0,22,1,0,0, ,0,0,0,0
#107500,COOKIE BAKED GRANDMA,60 CT,0,7,F,School,CS,13.3,0,0,1,0,0, ,0,0,0,0

#Item(id: integer, name: string, units: integer, issue: string, sort: integer, created_at: datetime, updated_at: datetime, itemtype_id: integer, mon: boolean, tue: boolean, wed: boolean, thu: boolean, fri: boolean)
#Price(id: integer, item_id: integer, start: date, expire: date, price_in_cents: integer, cost_in_cents: integer, created_at: datetime, updated_at: datetime)


# => {"commit"=>"Create",

#"price"=>{"item_id"=>"", "cost"=>"10", "price"=>"20", "start"=>"2009-02-02"},
#"item"=>{"name"=>"test", "wed"=>"1", "mon"=>"1", "thu"=>"1", "units"=>"12", "tue"=>"1", "itemtype_id"=>"9", "issue"=>"ea", "fri"=>"1", "sort"=>"3333", "sitetype_ids"=>["4", "2"]}}



#studentNumbers = Student.find(:all).collect{|s| s.number}

newitems = IO.readlines("Inventory_Items.csv")

#=> "\"005\",\"40016892\",\"Quarterman\",\"Dominique\",\"05\",\"E\",\"Chaney\",\"600\",\"00\",\"19981002\",\"M/ Bennett\",\"1744 W Juno Av #A\",\"Anaheim \",\"92804\",\"7143128704\"\r\n"
listorder = 5999

  for newitem in newitems
    
    listorder += 1

    
    (number, description, pack, last_iss_rct, type, category, use_code,
     unit_of_iss, fair_mkt, surplus_amt, dfc_amt, unit_factor, serv_factor, bid_qty,
     staple_item, vendor_number, last_ord_cost, last_ord_qty, ytd_ord_qty) = newitem.split(",")
    
    use_code.downcase!
    
    if use_code == "both"
      codes = [1,2,3,4]
    elsif use_code == "dfc"
      codes = [4]
    else
      codes = [1,2,3]
    end
    
    itemstuff = {:name=>description.downcase, :units=>pack.gsub(/[a-zA-Z ]/,'').to_i, :issue=>unit_of_iss, :sort=>listorder,
              :mon=>true, :tue=>true, :wed=>true, :thu=>true, :fri=>true, :sitetype_ids=>codes}

    
    
    item = Item.new(itemstuff)
    if item.save
      pricestuff = {:item_id=>item.id, :start=>Date.parse("2008-1-1"), :cost_in_cents=>fair_mkt.gsub(".","").to_i, :price_in_cents=>dfc_amt.gsub(".","").to_i}
      price = Price.new(pricestuff)
      price.save
    end

  
  end

