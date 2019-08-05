class SessionsController < ApplicationController
  def new; end

  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase

    if user&.authenticate session[:password]
      if user.activated?
        login_activated user
      else
        login_not_activated
      end
    else
      flash.now[:danger] = t "invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_activated user
    log_in user
    session[:remember_me] == Settings.check_re ? remember(user) : forget(user)
    redirect_back_or user
  end

  def login_not_activated
    flash[:warning] = t "please_check"
    redirect_to root_url
  end
end
