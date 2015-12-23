class SessionsController < ApplicationController
  def new
  end

  def create
    tester = Tester.find_by(email: params[:session][:email].downcase)
    if tester && tester.authenticate(params[:session][:password])
      # Log the tester in and redirect to the tester's show page.
      log_in tester
      redirect_to tester
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
