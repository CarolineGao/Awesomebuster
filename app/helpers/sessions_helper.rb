module SessionsHelper

  # Logs in the given tester.
  def log_in(tester)
    session[:tester_id] = tester.id
  end

  # Returns the current logged-in tester (if any).
  def current_tester
    @current_tester ||= Tester.find_by(id: session[:tester_id])
  end

  # Returns true if the tester is logged in, false otherwise.
  def logged_in?
    !current_tester.nil?
  end

  # Logs out the current tester
  def log_out
    session.delete(:tester_id)
    @current_tester = nil
  end
  
end
