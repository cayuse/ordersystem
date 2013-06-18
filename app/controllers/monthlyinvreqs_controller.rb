class MonthlyinvreqsController < ApplicationController

  def index
    per_page = 10
    months = ((Monthlyinvreq.all :select=>'DISTINCT month', :order => "month DESC").map &:month)
    if months.index(Date.today.monday)
        params[:page] ||= (months.index(Date.today.monday)/per_page.to_f).ceil
    end
    @months = months.paginate :per_page => per_page, :page => params[:page]
    @monthlyinvreqs = Sitetype.sitetype_invreqs
    @sitetypes = @monthlyinvreqs.keys.sort
  end

  def show
    @monthlyinvreq = Monthlyinvreq.find(params[:id], :include => :monthlyinvs)
  end

  def new
    if params[:monthlyinvreq][:month] == ""
      flash[:error] = 'You Must Select a Site Type and Date to continue'
      return(render :action=>:start)
    end
    
    @sitetype = Sitetype.find(params[:monthlyinvreq][:sitetype_id])
    @date = Date.parse(params[:monthlyinvreq][:month]).beginning_of_month
    if @sitetype.monthlyinvreqs.collect{|t| t.month}.include?(@date)
        flash[:error] = 'Inventory Request Entered for that sitetype and month'
        return(render :action=>:start)
    end
  
    flash[:note] = 'Complete form for Inventory Request'
    @monthlyinvreq = Monthlyinvreq.new
  end

  def edit
    @monthlyinvreq = Monthlyinvreq.find(params[:id])
  end

  def start
    @monthlyinvreq = Monthlyinvreq.new
  end

  def create
    if params[:monthlyinvreq][:month]
      params[:monthlyinvreq][:month] = Date.parse(params[:monthlyinvreq][:month]).beginning_of_month
    end
    if params[:monthlyinvreq][:due]
      params[:monthlyinvreq][:due] = Date.parse(params[:monthlyinvreq][:due])
    end
    
    @monthlyinvreq = Monthlyinvreq.new(params[:monthlyinvreq])

    if @monthlyinvreq.save
      flash[:note] = 'Monthlyinvreq was successfully created.'
      redirect_to(@monthlyinvreq)
    else
      render :action => "index"
    end
  end

  def update
    @monthlyinvreq = Monthlyinvreq.find(params[:id])

    if @monthlyinvreq.update_attributes(params[:monthlyinvreq])
      flash[:note] = 'Monthlyinvreq was successfully updated.'
      redirect_to(@monthlyinvreq)
    else
      render :action => "edit"
    end
  end

  def destroy
    @monthlyinvreq = Monthlyinvreq.find(params[:id])
    @monthlyinvreq.destroy

    redirect_to(monthlyinvreqs_url)
  end
  
  def dispatch
    unless params[:sitetypes]
      flash[:error] = 'You must select at least one Site Type'
      return redirect_to(monthlyinvreqs_url)
    end

    @sitetypes = params[:sitetypes]
    @date = Date.parse(params[:month][:month])

    @monthlyinvreqs = Monthlyinvreq.find_all_by_sitetype_id(@sitetypes, :include => :monthlyinvs, :conditions =>["month = ?", @date])
    prawnto :prawn => {:page_layout => :landscape }
    case params[:submit]
      when "District Recap"
        render :file => 'monthlyinvreqs/recap.pdf.prawn'
      else
        redirect_to(monthlyinvreqs_url)
    end
    
  end 
  
end
