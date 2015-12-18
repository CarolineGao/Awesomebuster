class CompaniesController < ApplicationController

  def non_footer_action
    do_stuff
    @skip_footer = true
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "Welcome to join the Awesomebuster. Create your first product now!"
      redirect_to @company
    else
      render 'new'
    end
  end

  private
    def company_params
      params.require(:company).permit(:first_name, :last_name, :company_name, :email, :password, :password_confirmation)
    end

end
