class AccountsController < ApplicationController

  include SessionsHelper
  # GET /accounts
  # GET /accounts.json
  def index
    if current_user and Account.find_by_user_id(current_user[:id])
      @accounts = Account.where(current_user[:id])
    else
      redirect_to user_path, {:id => current_user[:id]}
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    if current_user and Account.find_by_user_id(current_user[:id])
      @accounts = Account.where(user_id: current_user[:id])
    else
      flash[:notice] = 'No accounts to View. Request one'
      redirect_to user_path, {:id => current_user[:id]}
    end
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(acc_no: rand(),balance: 0.0, state: 0, user_id: current_user[:id])
    respond_to do |format|
      if @account.save
        @account.update_attributes(acc_no: @account[:id])
        format.html { redirect_to @account, notice: 'Account was successfully requested' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  #
  # def update
  #   respond_to do |format|
  #     if @account.update(account_params)
  #       format.html { redirect_to @account, notice: 'Account was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @account }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @account.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find_by_acc_no(params[:id])
    @account.delete
    redirect_to user
    respond_to do |format|
      format.html { redirect_to user, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:acc_no, :balance, :state)
    end
end
