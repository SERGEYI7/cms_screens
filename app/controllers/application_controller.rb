# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  # after_action :verify_authorized#, except: :index
  # after_action :verify_policy_scoped#, only: :index

  alias current_user current_api_v1_user
  alias authenticate_user! authenticate_api_v1_user!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # private

  # def user_not_authorized(exception)
  #   policy_name = exception.policy.class.to_s.underscore

  #   flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
  #   redirect_back(fallback_url: root_path)
  # end
end
