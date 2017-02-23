class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  # GET /users
  # GET /users.json
  def index
    if current_user
      @users = User.except(params[:id])
    else
      redirect_to root_path
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end
  # GET /friends/1
  def show_friends
    if current_user
      @friends = Friend.where(user_id: current_user[:id])
    else
      flash[:notice] = "Please Login"
      redirect_to root_path
    end
  end

  def add_friends
    if current_user
      puts params
      temp = Friend.new(user_id: current_user[:id], friend_id: params[:id], fname: params[:name])
      if temp.save
        flash[:notice] = "A new Friend added. Make a transfer"
      else
        flash[:notice] = "Friend not added"
      end
      redirect_to friends_path
    else
      flash[:notice] = "Please Login"
      redirect_to root_path
    end
  end
  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Profile Created: Request an account"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    redirect_to login_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :phone)
    end
end
