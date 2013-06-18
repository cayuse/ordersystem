class WeeklyorderreqsController < ApplicationController

  def index

    per_page = 10
    weeks = ((Weeklyorderreq.all :select => 'DISTINCT week', :order => :week).map &:week)
    if weeks.index(Date.today.monday)
        params[:page] ||= (weeks.index(Date.today.monday)/per_page.to_f).ceil
    end
    @weeks = weeks.paginate :per_page => per_page, :page => params[:page]
    @weeklyorderreqs = Sitetype.sitetype_orderreqs
    @sitetypes = @weeklyorderreqs.keys.sort
  end

  def monthlyindex
    per_page = 10
    @monthhash = ((Weeklyorderreq.all :include => :sitetype, :order => :week).inject({}) {|h,w| h[w.week.beginning_of_month] ? h[w.week.beginning_of_month] += [w.sitetype] : h[w.week.beginning_of_month] = [w.sitetype]; h})
    @monthhash.each_value do |v|
	 v.sort!
	 v.uniq! 
    end
    test_day = Date.today.beginning_of_month - 1.month
    if @monthhash.keys.sort.index(test_day)
        params[:page] ||= (@monthhash.keys.sort.index(test_day)/per_page.to_f).ceil
        params[:page] = 1 if params[:page] == 0
    end
    @months = @monthhash.keys.sort.paginate :per_page => per_page, :page => params[:page]
  end

  def show
    @weeklyorderreq = Weeklyorderreq.find(params[:id])
  end

  def new
    if params[:weeklyorderreq][:week] == ""
      flash[:error] = 'You Must Select a Site Type and Date to continue'
      return(render :action=>:start)
    end

    @sitetype = Sitetype.find(params[:weeklyorderreq][:sitetype_id])
    @date = Date.parse(params[:weeklyorderreq][:week]).monday
    if @sitetype.weeklyorderreqs.collect{|t| t.week}.include?(@date)
      flash[:error] = 'Order Request Entered for that sitetype and week'
      return(render :action=>:start)
    end

    flash[:note] = 'Complete form for Order Request'
    @weeklyorderreq = Weeklyorderreq.new
  end

  def edit
    @weeklyorderreq = Weeklyorderreq.find(params[:id])
  end

  def start
    @weeklyorderreq = Weeklyorderreq.new
  end


  def create
    if params[:weeklyorderreq][:week]
      params[:weeklyorderreq][:week] = Date.parse(params[:weeklyorderreq][:week]).monday
    end
    if params[:weeklyorderreq][:due]
      params[:weeklyorderreq][:due] = Date.parse(params[:weeklyorderreq][:due])
    end

    params[:weeklyorderreq][:finalized] = false
    @weeklyorderreq = Weeklyorderreq.new(params[:weeklyorderreq])

    if @weeklyorderreq.save
      flash[:note] = 'Weeklyorderreq was successfully created.'
      @weeklyorderreq = Weeklyorderreq.find(@weeklyorderreq)
      redirect_to(@weeklyorderreq)
    else
      render :action => "index"
    end
  end

  def update
    if params[:weeklyorderreq][:week]
      params[:weeklyorderreq][:week] = Date.parse(params[:weeklyorderreq][:week]).monday
    end
    if params[:weeklyorderreq][:due]
      params[:weeklyorderreq][:due] = Date.parse(params[:weeklyorderreq][:due])
    end

    @weeklyorderreq = Weeklyorderreq.find(params[:id])

    if @weeklyorderreq.update_attributes(params[:weeklyorderreq])
      flash[:note] = 'Weeklyorderreq was successfully updated.'
      redirect_to(@weeklyorderreq)
    else
      render :action => "edit"
    end
  end

  def destroy
  @weeklyorderreq = Weeklyorderreq.find(params[:id])
  @weeklyorderreq.destroy

  redirect_to(weeklyorderreqs_url)
  end

  def dispatch
    unless params[:sitetypes] && params[:days]
      flash[:error] = 'You must select at least one Day, and at least one Site Type'
      return redirect_to(weeklyorderreqs_url)
    end
    sitetypes = params[:sitetypes]
    @days = params[:days].map{|i| i.to_i}
    @date = Date.parse(params[:week][:week])

    @orderreqs = Weeklyorderreq.find_all_by_sitetype_id(sitetypes, :conditions =>["week = ?", @date.monday])
    #@orderitems      = Orderitem.all :include => [ {:item => [:itemtype, :prices]}, {:weeklydfcorder => :weeklyorderreq}],  :conditions => { :weeklydfcorder_id   => @weeklydfcorders.map(&:id) }
    @orders = Weeklydfcorder.all :include => {:orderitems => [{:weeklydfcorder => :weeklyorderreq}, {:item => :prices}]}, :conditions => {:weeklyorderreq_id => @orderreqs.map(&:id)}
    #@orders = @orderreqs.map{|w| w.weeklydfcorders}.flatten
    @items = @orders.map{|o| o.orderitems}.flatten
    @items.sort!

    case params[:submit]

    when "Separate By Day"
      @data = ReportDrawer.separate_by_day(@date, @items, @days)
      @date = @date.monday
      render :file => 'weeklyorderreqs/separate_by_day.pdf.prawn'
    when "Combined Totals"
      @data = ReportDrawer.combined_totals(@date, @items)
      @date = @date.monday
      render :file => 'weeklyorderreqs/combined_totals.pdf.prawn'
    when "Separate With Site Breakdown"
      @data = ReportDrawer.separate_with_site_breakdown(@date, @items, @days)
      @date = @date.monday
      render :file => 'weeklyorderreqs/separate_with_site_breakdown.pdf.prawn'
    when "Invoices"
      render :file => 'weeklyorderreqs/invoices.pdf.prawn'
    when "Weekly Site Confirmations"
      render :file => 'weeklyorderreqs/confirmations.pdf.prawn'
    else
    redirect_to(weeklyorderreqs_url)
    end
  end

  def monthsdispatch
    unless params[:sitetypes]
      flash[:error] = 'You must select at least one Site Type'
      return redirect_to '/weeklyorderreqs/monthlyindex'
    end

    sitetypes = params[:sitetypes]
    @date = Date.parse(params[:month][:month])

    @weeklyorderreqs = Weeklyorderreq.all :include    => :sitetype, :conditions => { :week => @date.monday..@date.end_of_month, :sitetype_id => sitetypes }
    @weeklydfcorders = Weeklydfcorder.all :conditions => { :weeklyorderreq_id   => @weeklyorderreqs.map(&:id) }
    @orderitems      = Orderitem.all :include => [ {:item => [:itemtype, :prices]}, {:weeklydfcorder => :weeklyorderreq}],  :conditions => { :weeklydfcorder_id   => @weeklydfcorders.map(&:id) }
    @sitetypes = Sitetype.find sitetypes


    case params[:submit]

    when "Separate by Site"
      render :file => 'weeklyorderreqs/monthly_sep_by_site.pdf.prawn'
    when "Combined Total"
      render :file => 'weeklyorderreqs/monthly_combined.pdf.prawn'
    else
      redirect_to '/weeklyorderreqs/monthlyindex'
    end

  end


end
