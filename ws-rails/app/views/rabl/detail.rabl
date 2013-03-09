object :@group, :root => false

attributes :id, :restaurant, :description, :due_date, :name, :created_at

 child(:user => :owner) {
    attributes :id, :name, :email
 }

 child(:orders) {
     child(:user) {
        attributes :id, :name, :email
     }
     child(:order_dishes) {
        attributes :id, :dish_id, :quantity

        child(:dish) {
            attributes :id, :name, :price
        }
     }
 }


