# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  CURRENCY_PROPS = {
    unit: ' €',
    separator: '.',
    delimiter: ' ',
    precision: 2
  }.freeze
end
