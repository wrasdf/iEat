object :@orders, :root => false

child(:@unpaid_orders){
    attributes :id, :group, :created_at
    child(:user){
        attributes :name, :email, :telephone
    }
    child(:order_dishes) {
        attributes :dish_id, :quantity
        glue (:dish){
            attributes :name, :price
        }
    }
}

child(:@payback_orders){
    attributes :id, :group, :created_at
    child(:user){
        attributes :name, :email, :telephone
    }
    child(:order_dishes) {
        attributes :dish_id, :quantity
        glue (:dish){
            attributes :name, :price
        }
    }
}
