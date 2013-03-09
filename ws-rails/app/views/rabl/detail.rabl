object :@group, :root => false
attributes :id, :restaurant, :description, :due_date, :name, :created_at

child(:user => :owner) {
    attributes :name, :email
}

child(:orders) {
    child(:user) {
        attributes :name, :email
    }
    child(:order_dishes) {
        attributes :dish_id, :quantity
    }
}

