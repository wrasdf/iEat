object :@order

attributes :id, :group, :created_at

child(:order_dishes) {
    attributes :id, :quantity
}