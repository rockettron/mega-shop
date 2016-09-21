# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.create(title: "Sony", description: "mobile", price: 300)
Product.create(title: "IPhone 6s", description: "mobile phone", price: 800)
Product.create(title: "LG Nexus 5", description: "mobile of google", price: 500)
Product.create(title: "Lenovo", description: "black", price: 150)

user1 = User.registration("Viktor", "Presniatski", "presniatski@gmail.com", "1234")
user2 = User.registration("Dmitri", "Rozhkov", "cool_user@mail.ru", "5678")
user3 = User.registration("Andrew", "Kozlov", "andruxa@yandex.ru", "9101")

pr1 = Product.find(1)
pr2 = Product.find(2)
pr3 = Product.find(3)
pr4 = Product.find(4)

cart = user1.select_active_cart
cart.add_product(pr1)
item = cart.add_product(pr3)
cart.add_product(pr2)
item.increase!
order = cart.check_out("Dzerzhinskogo street, 95")

cart = user2.select_active_cart
cart.add_product(pr3)
cart.add_product(pr4)
cart.add_product(pr4)
cart.add_product(pr2)
order = cart.check_out("J. Kolasa street, 9")

cart = user1.select_active_cart
item = cart.add_product(pr4)
item.increase!(3)
cart.add_product(pr2)
order = cart.check_out("Platonova street, 54")

cart = user2.select_active_cart
item = cart.add_product(pr1)
item.increase!
item = cart.add_product(pr3)
item.increase!
cart.add_product(pr2)
order = cart.check_out("Gicalo street, 21")

cart = user3.select_active_cart
cart.add_product(pr1)
cart.add_product(pr2)
cart.add_product(pr3)
cart.add_product(pr4)
order = cart.check_out("Surganova street, 1")




