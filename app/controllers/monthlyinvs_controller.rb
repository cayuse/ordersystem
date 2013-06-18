class MonthlyinvsController < ApplicationController

  def index
    if @site = Setting.current_site
      @monthlyinvreqs = Monthlyinvreq.find_all_by_sitetype_id(@site.sitetype.id, :order=>"month DESC")
      @monthlyinvs = Monthlyinv.find_all_by_site_id(@site)
    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def show
    @monthlyinv = Monthlyinv.find(params[:id], :include => [:monthlyinvitems, :items])
    test_viewable(@monthlyinv)
  end

  def edit
    @monthlyinv = Monthlyinv.find(params[:id])
    test_writable(@monthlyinv)
    site = Setting.current_site

    @storelocs = Storeloc.find_all_by_site_id site.id, :order => :number
    @monthlyinv_hash = @monthlyinv.allitems_for_site(Setting.current_site)
  end

  def create
    if @site = Setting.current_site
      monthlyreq = params[:id]
      @monthlyinv = Monthlyinv.new( :attributes => { :site_id=>@site.id, :monthlyinvreq_id => monthlyreq } )
      if @monthlyinv.save
        flash[:note] = 'Monthly Inventory was successfully created.'
        redirect_to(edit_monthlyinv_path(@monthlyinv))
      else
        @monthlyinv = Monthlyinv.find :first, :conditions => [ "monthlyinvreq_id = ? AND site_id = ?", monthlyreq, @site.id ]
        if @monthlyinv
          flash[:error] = "Monthly Inventory exists. Did you double click?"
          redirect_to(edit_monthlyinv_path(@monthlyinv))
        else
          flash[:error] = "You Don't have an inventory for this month, yet it couldn't save. Please Try Again"
          redirect_to monthlyinvs_url
        end
      end

    else
      flash[:error] = 'No Site Selected. Please Select a Site prior to proceeding.'
      redirect_to(setting_url, :action=>'edit')
    end
  end

  def update
    @monthlyinv = Monthlyinv.find(params[:id])

    test_writable(@monthlyinv)
    redir = params[:referred][:referred] ? params[:referred][:referred] : monthlyinvs_url
    if session[:clickcode]
      redirect_to(redir)
    else
      session[:clickcode] = true
      if @monthlyinv.update_attributes(params[:monthlyinv])
        flash[:note] = 'Monthlyinv was successfully updated.'

        redirect_to(redir)
      else
        render :action => "edit"
      end
    end
  end

  def destroy
    @monthlyinv = Monthlyinv.find(params[:id])
    test_writable(@monthlyinv)
    @monthlyinv.destroy

    redirect_to(monthlyinvs_url)
  end

  def test_viewable(monthlyinv)
    unless Goldberg.user.authorized_for_site?(@monthlyinv.site)
      flash[:error] = "You do not have access to update that inventory"
      return redirect_to monthlyinvs_url
    end
    return true
  end

  def test_writable(monthlyinv)
    unless monthlyinv.monthlyinvreq.due >= Date.today
      flash[:error] = "This inventory is past due.  Editing is Prohibited"
      return redirect_to monthlyinvs_url
    end
    test_viewable(monthlyinv)
  end

end
