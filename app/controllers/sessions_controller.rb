class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "welcome"
      redirect_to new_post_url
    else
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
  end

  def delete
    sign_out
    redirect_to login_path
  end

  #private
  #  def user_params
  #    params.require(:user).permit(:email, :password)
  #  end
end
