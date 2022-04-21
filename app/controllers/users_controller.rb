# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    user = User.new(name: "new user", email: "asd@dsa.ruu", password: "password")
    user.save
    render json: { data: "проба пера" }, status: :ok
  end
end
