module ProductsHelper
  def toggle_state_link(product)
    title, btn_class =\
     case product.state
     when 'hidden' then ['Publish', 'btn-primary']
     when 'published' then ['Hide from search', 'btn-danger']
     when 'under_offer' then accept_offer(product)
     when 'sold' then ['Sold', 'btn-secondary disabled']
     end

    link_to title, toggle_state_product_path(product), class: "btn #{btn_class}", method: :post
  end

  def accept_offer(product)
    link_to 'Accept', accept_offer_product_path(product), class: 'btn btn-success', method: :post
  end
end
