# frozen_string_literal: true

class AuthorizedService < ApplicationService
  include Pundit::Authorization

  def initialize(current_user:)
    @current_user = current_user
  end

  private

  attr_reader :current_user
end
