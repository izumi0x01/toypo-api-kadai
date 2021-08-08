class ApplicationController < ActionController::API
  # include ActionController::HttpAuthentication::Token::ControllerMethods

  # before_action :authenticate

  # private

  # def authenticate
  #   authenticate_or_request_with_http_token do |token, options|
  #     token = Store.find_by(token: token).present?
  #   end
  # end

  # def current_store
  #   @current_store ||= Store.find_by(token: request.headers['Authorization'].split[1])
  # end
end
