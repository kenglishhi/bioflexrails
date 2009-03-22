class BiodatabasesController < ApplicationController
  # GET /biodatabase
  # GET /biodatabase.xml
  def index
    @biodatabase = Biodatabase.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @biodatabase }
    end
  end

  # GET /biodatabase/1
  # GET /biodatabase/1.xml
  def show
    @biodatabase = Biodatabase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @biodatabase }
    end
  end

  # GET /biodatabase/new
  # GET /biodatabase/new.xml
  def new
    @biodatabase = Biodatabase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @biodatabase }
    end
  end

  # GET /biodatabase/1/edit
  def edit
    @biodatabase = Biodatabase.find(params[:id])
  end

  # POST /biodatabase
  # POST /biodatabase.xml
  def create
    @biodatabase = Biodatabase.new(params[:biodatabase])

    respond_to do |format|
      if @biodatabase.save
        flash[:notice] = 'Biodatabase was successfully created.'
        format.html { redirect_to(@biodatabase) }
        format.xml  { render :xml => @biodatabase, :status => :created, :location => @biodatabase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @biodatabase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /biodatabase/1
  # PUT /biodatabase/1.xml
  def update
    @biodatabase = Biodatabase.find(params[:id])

    respond_to do |format|
      if @biodatabase.update_attributes(params[:biodatabase])
        flash[:notice] = 'Biodatabase was successfully updated.'
        format.html { redirect_to(@biodatabase) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @biodatabase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /biodatabase/1
  # DELETE /biodatabase/1.xml
  def destroy
    @biodatabase = Biodatabase.find(params[:id])
    @biodatabase.destroy

    respond_to do |format|
      format.html { redirect_to(biodatabase_url) }
      format.xml  { head :ok }
    end
  end
end
