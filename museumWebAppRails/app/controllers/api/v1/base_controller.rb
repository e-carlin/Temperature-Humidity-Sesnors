class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :require_login
  before_action :destroy_session
  

  def destroy_session
    request.session_options[:skip] = true
  end
end