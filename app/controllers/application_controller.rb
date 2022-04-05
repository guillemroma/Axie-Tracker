class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  require_relative './modules/select_teams.rb'
  require_relative './modules/add_axie.rb'
  require_relative './modules/exchange.rb'
  require_relative './modules/coin.rb'
  require_relative './modules/info.rb'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
