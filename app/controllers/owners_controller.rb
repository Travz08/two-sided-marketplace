class OwnersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_owner, only: [:show, :edit, :update, :destroy]

  # GET /owners
  # GET /owners.json
  def index
    @owners = Owner.all
    if params[:search]
    @owners = Owner.search(params[:search]).order("created_at DESC")
    else
      @owners = Owner.all.order("created_at DESC")
    end
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
    @items = Item.where(owner_id: @owner.id)
    session[:conversations] ||= []

     @users = User.all.where.not(id: current_user)
     @conversations = Conversation.includes(:recipient, :messages)
                                  .find(session[:conversations])
  end

  # GET /owners/new
  def new
    if current_user.owner.present?
      redirect_to owner_path(current_user.owner.id)
    else
    @owner = Owner.new
    end
  end

  # GET /owners/1/edit
  def edit
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = Owner.new(owner_params)
    @owner.user = current_user
    respond_to do |format|
      if @owner.save
        format.html { redirect_to @owner, notice: 'Owner was successfully created.' }
        format.json { render :show, status: :created, location: @owner }
      else
        format.html { render :new }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owners/1
  # PATCH/PUT /owners/1.json
  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to @owner, notice: 'Owner was successfully updated.' }
        format.json { render :show, status: :ok, location: @owner }
      else
        format.html { render :edit }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    @owner.destroy
    respond_to do |format|
      format.html { redirect_to owners_url, notice: 'Owner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_params
      params.require(:owner).permit(:image, :first_name, :last_name, :bio, :address, :city, :country, :postcode, :user_id)
    end
end
