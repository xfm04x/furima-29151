class ApplicationController < ActionController::Base
  before_action :basic_auth
  # basic認証private以下にメソッドとして定義↑呼び出し
  # 内容記述OK
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_day])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end
end
