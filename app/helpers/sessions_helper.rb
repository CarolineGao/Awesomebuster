module SessionsHelper

  # Logs in the given tester.
  def log_in(tester)
    session[:tester_id] = tester.id
  end

  # Remembers a user in a persistent session.
  def remember(tester)
    tester.remember
    cookies.permanent.signed[:tester_id] = tester.id
    cookies.permanent[:remember_token] = tester.remember_token
  end

  # Returns the current logged-in tester (if any).
  def current_tester
    if (tester_id = session[:tester_id])
      @current_tester ||= Tester.find_by(id: session[:tester_id])
    elsif (tester_id = cookies.signed[:tester_id])
      tester = Tester.find_by(id: tester_id)
      if tester && tester.authenticated?(cookies[:remember_token])
        log_in tester
        @current_tester = tester
      end
    end
  end

  # Returns true if the tester is logged in, false otherwise.
  def logged_in?
    !current_tester.nil?
  end

  # Forgest a persistent session.
  def forget(tester)
    tester.forget
    cookies.delete(:tester_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current tester
  def log_out
    forget(current_tester)
    session.delete(:tester_id)
    @current_tester = nil
  end

end
