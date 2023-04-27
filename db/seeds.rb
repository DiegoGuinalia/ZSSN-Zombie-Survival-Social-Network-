# This creates accepted items

  items = Item.accepted_items

  items.each do |key, val|
    Item.create(
      name: key.to_s,
      price: val
    )
  end
