# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    return Pundit::NotAuthorizedError, "must be logged in" unless user

    @user = user
    @model = model
  end

  def index?
    pass_check?
  end

  def show?
    pass_check?
  end

  def create?
    pass_check?
  end

  def update?
    pass_check?
  end

  def destroy?
    pass_check?
  end

  private

  def pass_check?
    user.id == model.user_id
  end
end
