class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:show, :edit, :update, :destroy]

  # GET /borrows
  # GET /borrows.json
  def index
    @borrows = Borrow.where(:friend_id => params[:user_id])
  end

  # GET /borrows/1
  # GET /borrows/1.json
  def show
  end

  # GET /borrows/new
  def new
    @borrow = Borrow.new
    @borrow.user_id = params[:user_id]
    @borrow.friend_id = params[:friend_id]
    if Account.where(:user_id => params[:friend_id]).empty?
      redirect_to borrows_path(:user_id => current_user[:id]),  notice: 'That person has no accounts'
    end
    @borrow.state ='pending'
    @borrow.friend_name = User.find_by(:id => @borrow.friend_id).name
    @borrow.user_name = User.find_by(:id => @borrow.user_id).name
    @list = Account.where(:user_id => @borrow.friend_id, :state => 'active' )
    @list2 = Account.where(:user_id => @borrow.user_id, :state => 'active')
  end

  def accept_offer
    @borrow = Borrow.find_by(:id => params[:borrow_id])
    @account1=Account.find_by(:acc_no => @borrow.from_acc)
    @account2=Account.find_by(:acc_no => @borrow.to_acc)
    @temp=@account2.balance-@borrow.amount
    if @temp < 0
      @temp = -1 * @temp
      redirect_to borrows_path(:user_id => current_user[:id]),  notice: 'Cannot lend because of insufficient funds. You are $'+@temp.to_s+' short'
      return
    end
    @account2.update_attribute(:balance,@temp)
    @temp=@account1.balance+@borrow.amount
    @account1.update_attribute(:balance,@temp)
    @borrow.update_attribute(:state, 'accepted')
  end

  def reject_offer
    @borrow = Borrow.find_by(:id => params[:borrow_id])
    @borrow.update_attribute(:state, 'rejected')
  end


  # GET /borrows/1/edit
  def edit
  end

  # POST /borrows
  # POST /borrows.json
  def create
    @borrow = Borrow.new(borrow_params)

    respond_to do |format|
      if @borrow.save
        format.html { redirect_to @borrow, notice: 'Borrow was successfully created.' }
        format.json { render :show, status: :created, location: @borrow }
      else
        format.html { render :new }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /borrows/1
  # PATCH/PUT /borrows/1.json
  def update
    respond_to do |format|
      if @borrow.update(borrow_params)
        format.html { redirect_to @borrow, notice: 'Borrow was successfully updated.' }
        format.json { render :show, status: :ok, location: @borrow }
      else
        format.html { render :edit }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrows/1
  # DELETE /borrows/1.json
  def destroy
    @borrow.destroy
    respond_to do |format|
      format.html { redirect_to borrows_url, notice: 'Borrow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_borrow
      @borrow = Borrow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def borrow_params
      params.require(:borrow).permit(:user_id, :friend_id, :friend_name, :amount, :state, :from_acc, :to_acc, :user_name)
    end
end
