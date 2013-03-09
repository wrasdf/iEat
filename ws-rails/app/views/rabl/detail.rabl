object :@group
attributes :id, :restaurant, :description, :due_date, :name, :created_at

child(:user => :owner) {
    attributes :id, :name, :email
}

child(:orders) {
    attributes :id, :group, :created_at

    child(:order_dishes) {
        attributes :id, :quantity
    }
}

