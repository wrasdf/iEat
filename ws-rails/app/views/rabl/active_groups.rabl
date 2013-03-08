collection :@active_groups
attributes :id, :name, :created_at, :due_date
child(:user => :owner) {
    attributes :id, :name, :email
}
child(:restaurant) {
    attributes :id, :name, :telephone, :address
}