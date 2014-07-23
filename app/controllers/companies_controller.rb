class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.xml

  def home
    @body_id = "home"
    @comp_new = Company.find(:all, :conditions => ["deleted = ?", false], :order => "created_at desc", :limit => 5)
  end
  
  def index
    #@title = "Companies"
    @body_id = "companies"
    @letters = "#,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z".split(",") 
    @curr_link = "Companies"
    if params[:id]
      @initial = params[:id]
    else
      @initial = "A"
    end  
    if params[:id] == '#'
      @companies = Company.find(:all, :conditions => ["company_name < 'A'"], :order => "company_name")
    else
      @companies = Company.find(:all, :conditions => ["company_name like ?", @initial+'%'], :order => "company_name")
    end
    @comp_new = Company.find(:all, :order => "created_at desc", :limit => 5)
    @comp_upd = Company.find(:all, :order => "updated_at desc", :limit => 5)
  #@companies = Company.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end
  

  # GET /companies/1
  # GET /companies/1.xml
  def show
    #@company = Company.find(params[:id])
    
    @body_id = "companies"
    @company = Company.find(params[:id])
    #@meta_content = "<meta content = '" + @company.overview[0..255] + "' />"
    @meta_content = @company.overview[0..255]
    unless @company.tags.empty?
      @meta_tags = @company.tag_list
    end
    @map = ""
    $company_id = @company.id
    @curr_link = @company.company_name
    @products = Product.find(:all, :conditions => ["company_id = ?", @company.id], :order => "product_name")
    if (@company.address1 != nil) || (@company.address2 != nil) || (@company.state) || (@company.postal_code)
      if @company.address1 != nil
        @map = @company.address1
      end
      if @company.address2 != nil
        if @map != ""
          @map = @map + " " + @company.address2  
        else
          @map = @company.address2
        end  
      end
      if @company.state_code != nil
        if @map != ""
          @map = @map + ", " + @company.state_code
        else
          @map = @company.state_code
        end 
      end
      if @company.postal_code != nil
        if @map != ""
          @map = @map + " " + @company.postal_code
        else
          @map = @company.postal_code
        end 
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new
    @categories = Category.find(:all, :order => "title")
    3.times { @company.products.build }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    @categories = Category.find(:all, :order => "title")
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(@company, :notice => 'Company was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def add_products
    @company = Company.find(params[:id])
    @company.products.build
  end
  

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
end
