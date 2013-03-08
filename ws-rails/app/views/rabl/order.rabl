object :@order

attributes :id, :group

child(:order_dishes) {
    attributes :id, :quantity
}