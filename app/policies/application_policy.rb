# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    user.present?
  end
end
