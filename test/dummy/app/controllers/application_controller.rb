class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    #Your current user. Temporarily setting current user to first user
    User.first
  end
end
