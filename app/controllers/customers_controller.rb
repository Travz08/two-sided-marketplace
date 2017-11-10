class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :destroy, :update]
  skip_before_action :verify_authenticity_token

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    @owners = Owner.all
    if params[:search]
    @owners = Owner.search(params[:search]).order("created_at DESC")
    else
      @owners = Owner.all.order("created_at DESC")
    end
    @customers.each do |customer|
      puts customer.latitude
      puts customer.longitude
    end
    @hash = Gmaps4rails.build_markers(@owners) do |owner, marker|
      location_link = view_context.link_to owner.first_name, owner_path(owner)
      marker.lat owner.latitude
      marker.lng owner.longitude
      marker.infowindow "<h4><u>#{location_link}</u></h4>
                      <i>#{owner.first_name}</i>"
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    if current_user.customer.present?
      redirect_to customer_path(current_user.customer.id)
    else
    @customer = Customer.new
    end
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    # @lng = params[:lng]
    # @lat = params[:lat]
    @customer = Customer.new(customer_params)
    @customer.user = current_user
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def location
    @lng = params[:lng]
    @lat = params[:lat]
    puts @lng
    @customer = Customer.find(current_user.customer.id)
    @customer.update(latitude: @lat, longitude: @lng)
    @customer.save
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:image, :first_name, :last_name, :bio, :address, :city, :country, :postcode, :user_id)
    end
end
