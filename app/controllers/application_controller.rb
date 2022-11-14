class ApplicationController < ActionController::Base
  helper_method :set_current_user, :current_user, :signed_in?, :user_param, :user_header

  before_action :set_current_user

  def set_current_user
    @current_user = Accounts::User.find_by name: (user_param || user_header)
  end
  attr_reader :current_user

  def signed_in?
    current_user.present?
  end

  def user_param
    params[:u].presence
  end

  def user_header
    request.headers["X-User"].presence
  end
end
