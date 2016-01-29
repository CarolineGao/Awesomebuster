class TestersController < ApplicationController
  before_action :logged_in_tester, only: [:index, :edit, :update, :destroy]
  before_action :correct_tester,     only: [:edit, :update]
  before_action :admin_tester,       only: :destroy

  def non_footer_action
    do_stuff
    @skip_footer = true
  end

  def index
    @testers = Tester.paginate(page: params[:page])
  end

  def show
    @tester = Tester.find(params[:id])
  end

  def new
    @tester = Tester.new
  end

  def create
    @tester = Tester.new(tester_params)
    if @tester.save
      @tester.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @tester = Tester.find(params[:id])
  end

  def update
    @tester = Tester.find(params[:id])
    if @tester.update_attributes(tester_params)
      flash[:success] = "Profile updated"
      redirect_to @tester
    else
      render 'edit'
    end
  end

  def destroy
    Tester.find(params[:id]).destroy
    flash[:success] = "Tester deleted"
    redirect_to testers_url
  end

  private
    def tester_params
      params.require(:tester).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in tester.
    def logged_in_tester
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct tester.
    def correct_tester
      @tester = Tester.find(params[:id])
      redirect_to(root_url) unless current_tester?(@tester)
    end

    # Confirms an admin tester.
    def admin_tester
      redirect_to(root_url) unless current_tester.admin?
    end
end
