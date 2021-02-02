class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ConditionalCache

  private

  def current_user
    #Your current user. Temporarily setting current user to first user
    User.first
  end

  # add this method to support conditional caching at user level
  def conditional_get_key
    # return user or session specific identifier. Ex: auth_token or session id or user id
    # I choose to return user id in this sample implementation
    current_user.id
  end
end
