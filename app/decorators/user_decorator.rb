# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate_all

  def balance
    balance = object.balance

    h.content_tag :div, class: "alert alert-success" do
      h.concat 'Current Balance: '
      h.concat h.number_to_currency(balance, CURRENCY_PROPS)
    end
  end
end
