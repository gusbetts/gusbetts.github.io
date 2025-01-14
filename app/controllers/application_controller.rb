class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?
  helper_method :ordinalize
  before_filter :send_fucking_p3p

  def send_fucking_p3p # Goddamn this bullshit.
    response.headers['P3P'] = 'CP="NON CURa ADMa DEVa TAIa OUR BUS IND PHY UNI COM NAV DEM"';
  end

  def process_signed_request
    # if request.post? and params[:signed_request] and
    #     MiniFB.verify_signed_request(Anathief::Facebook::SECRET, params[:signed_request])
    #   fbinfo = MiniFB.signed_request_params(Anathief::Facebook::SECRET, params[:signed_request])

    #   if fbinfo.has_key?('user_id')
    #     fb_uid = fbinfo['user_id']
    #     fb_tok = session[:fb_tok] = fbinfo['oauth_token']
    #     logger.info "Got rq from auth'd user #{fb_uid}"
    #     logger.info "Tok #{fb_tok}"

    #     me = MiniFB.get(fb_tok, 'me')
    #     unless @current_user = User.find_by_uid(fb_uid)
    #       # do we ever reach this? Apparently so.
    #       logger.info "Strange: user account #{fb_uid} not found"
    #       logger.info "Creating new user for fbid #{fb_uid}"
    #       @current_user = User.create :uid => fb_uid
    #     end
    #     @current_user.update_from_graph(fb_tok, me)

    #     session[:user_id] = @current_user.id
    #   else
    #     logger.info "Not logged in anymore"

    #     session[:fb_tok] = nil

    #     # if logged in as fb user, logout
    #     if current_user and current_user.uid
    #       session[:user_id] = nil
    #       @current_user = nil
    #     end
    #   end

    #   return true
    # end
    return false
  end

  protected

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    elsif params[:login_token]
      login_token = params[:login_token]
      uid = verify_login_token(login_token)
      if uid
        logger.info "User has valid login token #{login_token}"
        @current_user ||= User.find(uid)
      end
    end

    @current_user
  end

  def user_signed_in?
    !!current_user
  end

  def require_user
    signed_in = user_signed_in?

    unless signed_in
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { render :json => {:status => false, :error => 'Login required'} }
      end
    end
    signed_in
  end

  def generate_login_token(user_id)
    return SignedData.encode({
      :user_id => user_id,
      :timestamp => Time.now.to_i,
    })
  end

  def verify_login_token(login_token, timeout_secs=0)
    signed_data = SignedData.decode login_token
    unless signed_data
      logger.warn "invalid login token #{login_token}"
      return nil
    end
    if timeout_secs > 0 and
        Time.at(signed_data['timestamp']) < Time.now - timeout_secs.second

      logger.warn "expired login token #{login_token}"
      return nil
    end

    return signed_data['user_id']
  end

  def generate_play_token(user_id, game_id, extra_data={})
    user = User.find(user_id)
    return SignedData.encode({
      :user_id => user_id,
      :game_id => game_id,
      :timestamp => Time.now.to_i,
      :name => user.name,
      :profile_pic => user.profile_pic
    }.merge(extra_data))
  end


  def oauth_url
    # MiniFB.oauth_url(Anathief::Facebook::APP_ID, sessions_fb_callback_url, :scope => '')
  end

  def ordinalize(value)
    Ordinalize.ordinalize value
  end

  def random_guest_name
    return "Guest #{100000 + rand(10000)}"
  end
end
