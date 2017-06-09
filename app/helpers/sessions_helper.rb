module SessionsHelper

  def sign_in(user)
    #session[:user_id] = user.id
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    current_user=(user)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    #if session[:user_id]
    #  @current_user ||= User.find_by(id: session[:user_id])
    #els
    @current_user ||= retrieve
  end

  def retrieve
    if cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end


  def sign_out
    #session.delete(:user_id)
    @current_user = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    !current_user.nil?
  end


end
