# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  alias current_user current_api_v1_user
  alias authenticate_user! authenticate_api_v1_user!
end
