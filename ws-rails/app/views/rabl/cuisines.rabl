collection :@cuisines, :root => false

attributes :name

child(:dishes) {
    attributes :name, :price
}