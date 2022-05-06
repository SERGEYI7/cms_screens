# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ArgumentError, with: :content_argument_error
  alias current_user current_api_v1_user
  alias authenticate_user! authenticate_api_v1_user!

  private

  def user_not_authorized
    render status: :not_found
  end

  def content_argument_error
    render json: ["position invalid"], status: :unprocessable_entity
  end
end
