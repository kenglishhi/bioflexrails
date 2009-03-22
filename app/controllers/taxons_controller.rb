class TaxonsController < ApplicationController
  # GET /taxon
  # GET /taxon.xml
  def index
    @taxons = Taxon.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @taxon }
    end
  end

  # GET /taxon/1
  # GET /taxon/1.xml
  def show
    @taxon = Taxon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @taxon }
    end
  end

  # GET /taxon/new
  # GET /taxon/new.xml
  def new
    @taxon = Taxon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @taxon }
    end
  end

  # GET /taxon/1/edit
  def edit
    @taxon = Taxon.find(params[:id])
  end

  # POST /taxon
  # POST /taxon.xml
  def create
    @taxon = Taxon.new(params[:taxon])

    respond_to do |format|
      if @taxon.save
        flash[:notice] = 'Taxon was successfully created.'
        format.html { redirect_to(@taxon) }
        format.xml  { render :xml => @taxon, :status => :created, :location => @taxon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @taxon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /taxon/1
  # PUT /taxon/1.xml
  def update
    @taxon = Taxon.find(params[:id])

    respond_to do |format|
      if @taxon.update_attributes(params[:taxon])
        flash[:notice] = 'Taxon was successfully updated.'
        format.html { redirect_to(@taxon) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @taxon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /taxon/1
  # DELETE /taxon/1.xml
  def destroy
    @taxon = Taxon.find(params[:id])
    @taxon.destroy

    respond_to do |format|
      format.html { redirect_to(taxon_url) }
      format.xml  { head :ok }
    end
  end
end
