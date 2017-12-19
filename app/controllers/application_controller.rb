class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  def current_user
    User.select(User.attribute_names - ['password_digest']).find(session[:user_id]) if session[:user_id]
  end

  def get_states
    %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)    
  end
  helper_method :current_user, :get_states
  
  private
    def require_login
      return redirect_to signin_path unless session[:user_id]
    end

    def get_zones
      zones = {
        "AL": "-06:00",
        "AK": "-09:00",
        "AZ": "-07:00",
        "AR": "-06:00",
        "CA": "-08:00",
        "CO": "-07:00",
        "CT": "-05:00",
        "DE": "-05:00",
        "FL": "-05:00",
        "GA": "-05:00",
        "HI": "-10:00",
        "ID": "-07:00",
        "IL": "-06:00",
        "IN": "-05:00",
        "IA": "-06:00",
        "KS": "-06:00",
        "KY": "-05:00",
        "LA": "-06:00",
        "ME": "-05:00",
        "MD": "-05:00",
        "MA": "-05:00",
        "MI": "-05:00",
        "MN": "-06:00",
        "MS": "-06:00",
        "MO": "-06:00",
        "MT": "-07:00",
        "NE": "-06:00",
        "NV": "-08:00",
        "NH": "-05:00",
        "NJ": "-05:00",
        "NM": "-07:00",
        "NY": "-05:00",
        "NC": "-05:00",
        "ND": "-06:00",
        "OH": "-05:00",
        "OK": "-06:00",
        "OR": "-08:00",
        "PA": "-05:00",
        "RI": "-05:00",
        "SC": "-05:00",
        "SD": "-06:00",
        "TN": "-06:00",
        "TX": "-06:00",
        "UT": "-07:00",
        "VT": "-05:00",
        "VA": "-05:00",
        "WA": "-08:00",
        "DC": "-05:00",
        "WV": "-05:00",
        "WI": "-06:00",
        "WY": "-07:00"
    }
  end
end
