class BioentriesController < ApplicationController
  # GET /bioentry
  # GET /bioentry.xml
  def index
    @bioentries = Bioentry.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bioentry }
    end
  end

  # GET /bioentry/1
  # GET /bioentry/1.xml
  def show
    @bioentry = Bioentry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bioentry }
    end
  end

  # GET /bioentry/new
  # GET /bioentry/new.xml
  def new
    @bioentry = Bioentry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bioentry }
    end
  end

  # GET /bioentry/1/edit
  def edit
    @bioentry = Bioentry.find(params[:id])
  end

  # POST /bioentry
  # POST /bioentry.xml
  def create
    @bioentry = Bioentry.new(params[:bioentry])

    respond_to do |format|
      if @bioentry.save
        flash[:notice] = 'Bioentry was successfully created.'
        format.html { redirect_to(@bioentry) }
        format.xml  { render :xml => @bioentry, :status => :created, :location => @bioentry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bioentry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bioentry/1
  # PUT /bioentry/1.xml
  def update
    @bioentry = Bioentry.find(params[:id])

    respond_to do |format|
      if @bioentry.update_attributes(params[:bioentry])
        flash[:notice] = 'Bioentry was successfully updated.'
        format.html { redirect_to(@bioentry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bioentry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bioentry/1
  # DELETE /bioentry/1.xml
  def destroy
    @bioentry = Bioentry.find(params[:id])
    @bioentry.destroy

    respond_to do |format|
      format.html { redirect_to(bioentry_url) }
      format.xml  { head :ok }
    end
  end
end
