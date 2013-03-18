collection :@active_groups, :root => false
attributes :id, :name, :created_at, :due_date
child(:user => :owner) {
    attributes :id, :name, :email
}
child(:restaurant) {
    attributes :id, :name, :telephone, :address
}

node(:joined) { |group| group.orders.any? {|order| order.user.email == @current_user.email} }
