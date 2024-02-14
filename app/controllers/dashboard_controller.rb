class DashboardController < ApplicationController
  def index
  end

  def notes
    @note = Note.new
    @notes = Note.where(user_id: auth_get_current_user.id)
  end

  def tags
    @tags = Tag.joins(:notes).distinct
  end

  def history
    @histories = History.all
    @notes = Note.where(user_id: auth_get_current_user.id)
  end
end
