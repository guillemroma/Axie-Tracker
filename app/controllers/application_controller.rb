class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  # config.autoload_paths += Dir.glob("#{config.root}/app/controllers/axie_api")
  # config.autoload_paths += Dir.glob("#{config.root}/app/controllers/coin")
  # config.autoload_paths += Dir.glob("#{config.root}/app/controllers/exchange")
  # config.autoload_paths += Dir.glob("#{config.root}/app/controllers/info")
  # config.autoload_paths += Dir.glob("#{config.root}/app/controllers/select_teams")

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
