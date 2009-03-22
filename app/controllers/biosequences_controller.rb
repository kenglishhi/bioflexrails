class BiosequencesController < ApplicationController
  # GET /biosequence
  # GET /biosequence.xml
  def index
    @biosequences = Biosequence.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @biosequence }
    end
  end

  # GET /biosequence/1
  # GET /biosequence/1.xml
  def show
    @biosequence = Biosequence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @biosequence }
    end
  end

  # GET /biosequence/new
  # GET /biosequence/new.xml
  def new
    @biosequence = Biosequence.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @biosequence }
    end
  end

  # GET /biosequence/1/edit
  def edit
    @biosequence = Biosequence.find(params[:id])
  end

  # POST /biosequence
  # POST /biosequence.xml
  def create
    @biosequence = Biosequence.new(params[:biosequence])

    respond_to do |format|
      if @biosequence.save
        flash[:notice] = 'Biosequence was successfully created.'
        format.html { redirect_to(@biosequence) }
        format.xml  { render :xml => @biosequence, :status => :created, :location => @biosequence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @biosequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /biosequence/1
  # PUT /biosequence/1.xml
  def update
    @biosequence = Biosequence.find(params[:id])

    respond_to do |format|
      if @biosequence.update_attributes(params[:biosequence])
        flash[:notice] = 'Biosequence was successfully updated.'
        format.html { redirect_to(@biosequence) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @biosequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /biosequence/1
  # DELETE /biosequence/1.xml
  def destroy
    @biosequence = Biosequence.find(params[:id])
    @biosequence.destroy

    respond_to do |format|
      format.html { redirect_to(biosequence_url) }
      format.xml  { head :ok }
    end
  end

  def to_image
    begin
      image = Biosequence.draw_graphic(Biosequence.find(params[:id]))
      send_data(image, :filename => "graphic.svg", :disposition => "inline")
    rescue  ActiveRecord::RecordNotFound
      add_error("Error:Attempt to call image without specifying a biosequence  ID")
      redirect_to :action=>'index'
    end
  end
end
