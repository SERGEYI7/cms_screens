# frozen_string_literal: true

class ApplicationService
  include Pundit::Authorization

  attr_accessor :current_user, :id, :name, :event_id, :screen_id, :playlist_id, :attachment, :content_id, :position

  def initialize(**kwargs)
    @id = kwargs[:id]
    @current_user = kwargs[:current_user]
    @name = kwargs[:name]
    @event_id = kwargs[:event_id]
    @screen_id = kwargs[:screen_id]
    @attachment = kwargs[:attachment]
    @playlist_id = kwargs[:playlist_id]
    @content_id = kwargs[:content_id]
    @position = kwargs[:position]
  end

  def self.call(**kwargs)
    new(**kwargs).call
  end

  def authorize_user_model(name_model, model, method)
    authorize model, method
  rescue StandardError
    OpenStruct.new(success?: false, name_model => nil, errors: ["must be logged in"])
  end
end
