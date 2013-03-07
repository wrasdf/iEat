collection :@restaurants => :restaurant_list

attributes :id, :name, :telephone, :address

child(:dishes) {
    attributes :id, :name, :price
}