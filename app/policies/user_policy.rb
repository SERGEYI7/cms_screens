# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.id == model.id
  end

  def show?
    user.id == model.id
  end
end
