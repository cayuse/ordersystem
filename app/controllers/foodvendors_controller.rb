class FoodvendorsController < ApplicationController
  # GET /foodvendors
  # GET /foodvendors.xml
  def index
    @foodvendors = Foodvendor.all :order => :name, :include => :nutritionals
    @nutritionals = Nutritional.all :order => :codenum, :include => :foodvendor

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @foodvendors }
    end
  end

  # GET /foodvendors/1
  # GET /foodvendors/1.xml
  def show
    @foodvendor = Foodvendor.find params[:id], :include => :nutritionals

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @foodvendor }
    end
  end

  # GET /foodvendors/new
  # GET /foodvendors/new.xml
  def new
    @foodvendor = Foodvendor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @foodvendor }
    end
  end

  # GET /foodvendors/1/edit
  def edit
    @foodvendor = Foodvendor.find(params[:id])
  end

  # POST /foodvendors
  # POST /foodvendors.xml
  def create
    @foodvendor = Foodvendor.new(params[:foodvendor])

    respond_to do |format|
      if @foodvendor.save
        flash[:notice] = 'Foodvendor was successfully created.'
        format.html { redirect_to(@foodvendor) }
        format.xml  { render :xml => @foodvendor, :status => :created, :location => @foodvendor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @foodvendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /foodvendors/1
  # PUT /foodvendors/1.xml
  def update
    @foodvendor = Foodvendor.find(params[:id])

    respond_to do |format|
      if @foodvendor.update_attributes(params[:foodvendor])
        flash[:notice] = 'Foodvendor was successfully updated.'
        format.html { redirect_to(@foodvendor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @foodvendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /foodvendors/1
  # DELETE /foodvendors/1.xml
#  def destroy
#    @foodvendor = Foodvendor.find(params[:id])
#    @foodvendor.destroy

#    respond_to do |format|
#      format.html { redirect_to(foodvendors_url) }
#      format.xml  { head :ok }
#    end
#  end
end
