class CallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => user.provider.titleize.split(" ").first
      sign_in_and_redirect user, :event => :authentication
    else
      session["count_errors"] = 0 if session["devise.user_attributes"] == nil
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
  alias_method :google_oauth2, :all
  alias_method :github, :all
end
