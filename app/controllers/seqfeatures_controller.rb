class SeqfeaturesController < ApplicationController
  # GET /seqfeature
  # GET /seqfeature.xml
  def index
    @seqfeatures = Seqfeature.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seqfeature }
    end
  end

  # GET /seqfeature/1
  # GET /seqfeature/1.xml
  def show
    @seqfeature = Seqfeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seqfeature }
    end
  end

  # GET /seqfeature/new
  # GET /seqfeature/new.xml
  def new
    @seqfeature = Seqfeature.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seqfeature }
    end
  end

  # GET /seqfeature/1/edit
  def edit
    @seqfeature = Seqfeature.find(params[:id])
  end

  # POST /seqfeature
  # POST /seqfeature.xml
  def create
    @seqfeature = Seqfeature.new(params[:seqfeature])

    respond_to do |format|
      if @seqfeature.save
        flash[:notice] = 'Seqfeature was successfully created.'
        format.html { redirect_to(@seqfeature) }
        format.xml  { render :xml => @seqfeature, :status => :created, :location => @seqfeature }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seqfeature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seqfeature/1
  # PUT /seqfeature/1.xml
  def update
    @seqfeature = Seqfeature.find(params[:id])

    respond_to do |format|
      if @seqfeature.update_attributes(params[:seqfeature])
        flash[:notice] = 'Seqfeature was successfully updated.'
        format.html { redirect_to(@seqfeature) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seqfeature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seqfeature/1
  # DELETE /seqfeature/1.xml
  def destroy
    @seqfeature = Seqfeature.find(params[:id])
    @seqfeature.destroy

    respond_to do |format|
      format.html { redirect_to(seqfeature_url) }
      format.xml  { head :ok }
    end
  end
end
