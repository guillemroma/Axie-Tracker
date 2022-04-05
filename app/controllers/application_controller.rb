class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  require_relative './select_teams/select_teams.rb'
  require_relative './axie_api/axie_api.rb'
  require_relative './exchange/exchange.rb'
  require_relative './coin/coin.rb'
  require_relative './info/info.rb'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
