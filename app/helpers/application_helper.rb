# frozen_string_literal: true

module ApplicationHelper
  def current_user_balance
    return unless signed_in?
    current_user.decorate.balance
  end
end
