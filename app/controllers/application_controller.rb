class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # サインアップ時の追加パラメータ
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])

  # サインイン時のパラメータを明示的に許可
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
