class PasswordResetsController < ApplicationController
  before_action :get_tester, only:[:edit, :update]
  before_action :valid_tester, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @tester = Tester.find_by(email: params[:password_reset][:email].downcase)
    if @tester
      @tester.create_reset_digest
      @tester.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:tester][:password].empty?
      @tester.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @tester.update_attributes(tester_params)
      log_in @tester
      flash[:success] = "Password has been reset."
      redirect_to @tester
    else
      render 'edit'
    end
  end

  private

    def tester_params
      params.require(:tester).permit(:password, :password_confirmation)
    end

    # Before filters
    def get_tester
      @tester = Tester.find_by(email: params[:email])
    end

    # Confirms a valid tester.
    def valid_tester
      unless (@tester && @tester.activated? &&
              @tester.authenticated?(:reset, params[:id]))
        redirect_to root_url
    end

    # Checks expiration of reset token.
    def check_expiration
      if @tester.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
  end
end
