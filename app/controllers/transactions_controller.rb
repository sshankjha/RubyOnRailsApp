class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
      @transactions = Transaction.where(:from => params[:from])
      @transactions2 = Transaction.where(:to => params[:from])
      @lends = Borrow.where(:to_acc => params[:from])
      @borrows = Borrow.where(:from_acc => params[:from])
  end

  def index_user
    @transactions = Transaction.where(:user_id => params[:user_id])
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @transaction.from = params[:from]
    @transaction.kind = params[:kind]
    @final = Account.new
    @account=Account.new
    @friend=Friend.new
    if @transaction.kind == 'transfer'
      @transaction.state = 'accepted'
      @account=Account.find_by(:acc_no => params[:from])
      @transaction.user_id = @account.user_id
      @friend=Friend.where(:user_id => @transaction.user_id)
      if @friend.empty?
        redirect_to account_path(:id => @transaction.user_id),  notice: 'Transfer not possible because you have not added any friends'
        return
      end
      @list=[]
      @friend.pluck(:friend_id).each do |i|
        @account=Account.where(:user_id => i)
        #flash[:i] = "printing"
        @account.each do |x|
          #flash[:x] = "printing"
          @list.push(x)
        end
      end
      @account=Account.where(:user_id => @transaction.user_id)
      @account.each do |x|
        if x.acc_no != @transaction.from
          @list.push(x)
      end
      @final=@list
      end
    end
    if @transaction.kind == 'deposit'
      @transaction.state = 'pending'
      @account=Account.find_by(:acc_no => params[:from])
      @transaction.user_id = @account.user_id
      @transaction.to=@transaction.from
    end
    if @transaction.kind == 'withdraw'
      @account=Account.find_by(:acc_no => params[:from])
      @transaction.user_id = @account.user_id
      @transaction.to=@transaction.from

    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @account1 = Account.new
    @account2 = Account.new
    @temp=0.0
    if @transaction.kind == 'transfer'
      @account1=Account.find_by(:acc_no => @transaction.from)
      @account2=Account.find_by(:acc_no => @transaction.to)
      @temp=@account1.balance-@transaction.amount
      if @temp < 0
        @temp = -1 * @temp
        redirect_to account_path(:id => @transaction.user_id),  notice: 'Cannot transfer because of insufficient funds. You are $'+@temp.to_s+' short'
        return
      end
      @account1.update_attribute(:balance,@temp)
      @temp=@account2.balance+@transaction.amount
      @account2.update_attribute(:balance,@temp)
      @transaction.confirmed = Time.now
    end
    if @transaction.kind == 'withdraw'
      @account1=Account.find_by(:acc_no => @transaction.from)
      @temp=@account1.balance-@transaction.amount
      if @temp < 0
        @temp = -1 * @temp
        redirect_to account_path(:id => @transaction.user_id),  notice: 'Cannot withdraw because of insufficient funds. You are $'+@temp.to_s+' short'
        return
      end
      if @transaction.amount < 1000
        @account1.update_attribute(:balance,@temp)
        @transaction.confirmed = Time.now
        @transaction.state = 'accepted'
      else
        @transaction.state = 'pending'
      end
    end
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:from, :to, :kind, :state, :amount, :user_id, :added, :confirmed)
    end
end
