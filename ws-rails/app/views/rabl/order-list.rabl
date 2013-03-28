object false
child(:@unpaid_orders){
    attributes :id, :created_at
    child(:group){
        attributes :name
        child(:user){
            attributes :id, :name, :email
        }
    }
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
    attributes :id, :created_at
        child(:group){
            attributes :name
            child(:user){
                attributes :id, :name, :email
            }
        }
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
