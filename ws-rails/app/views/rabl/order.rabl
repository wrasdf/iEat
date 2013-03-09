object :@order

attributes :id, :group, :created_at

child(:order_dishes) {
    attributes :dish_id, :quantity
}