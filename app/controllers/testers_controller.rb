class TestersController < ApplicationController

  def non_footer_action
    do_stuff
    @skip_footer = true
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
      log_in @tester
      flash[:success] = "Welcome to join the Awesomebuster. Explore a product now!"
      redirect_to @tester
    else
      render 'new'
    end
  end

  private
    def tester_params
      params.require(:tester).permit(:name, :email, :password, :password_confirmation)
    end
end
