class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new creat show)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: Settings.per_page)
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      flash[:danger] = t "danger"
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile"
      redirect_to @user
    else
      flash[:danger] = t "failse"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete"
    else
      flash[:danger] = t "delete_failse"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
