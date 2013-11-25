class WeeklydfcordersController < ApplicationController

  def index
    date = Date.today - 4.months
    if @site = Setting.current_site
      @weeklyorderreqs = Weeklyorderreq.find_all_by_sitetype_id(@site.sitetype.id, :conditions => ["week > ?", date], :order=>:week)
      @weeklydfcorders = Weeklydfcorder.find_all_by_site_id(@site)
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def show
    @user = Goldberg.user
    @weeklydfcorder = Weeklydfcorder.find(params[:id], :include=> :items)
    unless @user.authorized_for_site?(@weeklydfcorder.site)
      flash[:error] = "You do not have access to view that order"
      return redirect_to weeklydfcorders_url
    end
    @data = @weeklydfcorder.orderitems.sort.collect{ |b| [b.item.name, b.monqty, b.tueqty, b.wedqty, b.thuqty, b.friqty]}
  end

  def new
    @weeklydfcorder = Weeklydfcorder.new
  end

  def edit
    @weeklydfcorder = Weeklydfcorder.find(params[:id], :include=> [:items, :site])
    unless Goldberg.user.authorized_for_site?(@weeklydfcorder.site)
      flash[:error] = "You do not have access to edit that order"
      return redirect_to weeklydfcorders_url
    end
    @newitems = @weeklydfcorder.unused_items
  end

  def create
    if @site = Setting.current_site
      orderreq = params[:id].to_i
      @weeklydfcorder = @site.weeklydfcorders.build :attributes=>{ :weeklyorderreq_id => orderreq }
      if @weeklydfcorder.save
        flash[:note] = "Weekly DFC Order was successfully created."
        redirect_to(edit_weeklydfcorder_path(@weeklydfcorder))
      else
        @weeklydfcorder = Weeklydfcorder.find :first, :conditions => [ "weeklyorderreq_id = ? AND site_id = ?", orderreq, @site.id ]
        if @weeklydfcorder
          flash[:error] = "Weekly DFC Order exists. Did you double click?"
          redirect_to(edit_weeklydfcorder_path(@weeklydfcorder))
        else
          flash[:error] = "Something went terribly wrong. Please Try Again"
          redirect_to weeklydfcorders_url
        end
      end
      
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def update
    @weeklydfcorder = Weeklydfcorder.find(params[:id])
    unless Goldberg.user.authorized_for_site?(@weeklydfcorder.site)
      flash[:error] = "You do not have access to update that order"
      return redirect_to weeklydfcorders_url
    end
    @newitems = @weeklydfcorder.unused_items
    if @weeklydfcorder.update_attributes(params[:weeklydfcorder])
      flash[:note] = 'Weeklydfcorder was successfully updated.'
      
      redir = params[:referred][:referred] ? params[:referred][:referred] : weeklydfcorders_url
      redirect_to(redir)
    else
      render :action => "edit"
    end
  end

  def destroy
    @weeklydfcorder = Weeklydfcorder.find(params[:id])
    @weeklydfcorder.destroy

    redirect_to(weeklydfcorders_url)
  end
  
end
