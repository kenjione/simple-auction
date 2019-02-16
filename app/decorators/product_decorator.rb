class ProductDecorator < ApplicationDecorator
  delegate_all

  def price
    return original_price unless object.bid

    h.content_tag :div, class: 'prices' do
      h.concat h.content_tag :span, format_price(object.bid_amount), class: "price-bid #{object.state}"
      unless object.bid_amount == object.price
        h.concat h.content_tag :del, format_price(object.price), class: 'price-original'
      end
    end
  end

  def toggle_state_link
    h.content_tag :div, class: 'float-right' do
      h.toggle_state_link(object)
    end
  end

  def bid_link
    return unless h.signed_in?
    return h.content_tag :span, 'Sold', class: 'sold float-right' if object.state.sold?

    h.link_to 'Place a bid', h.new_product_bid_path(object), remote: true, class: 'float-right btn btn-primary'
  end

  private

  def original_price
    h.content_tag :span do
      format_price(object.price)
    end
  end

  def format_price(price)
    h.number_to_currency(price, CURRENCY_PROPS)
  end
end
