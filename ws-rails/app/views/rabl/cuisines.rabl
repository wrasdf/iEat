collection :@cuisines, :root => false

attributes :name

child(:dishes) {
    attributes :id, :name, :price
}