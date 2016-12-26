User.create!(name: "Jang Nara",
  email: "leductienttkt@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true,
  address: "Quang Tri",
  phone: "01688576549"
)

User.create!(name: "Nara",
  email: "le.duc.tien@framgia.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: false,
  address: "Hue",
  phone: "01234200394"
)

10.times do |n|
  name  = Faker::Name.name
  Category.create!(name: name)
end

categorys = Category.all

10.times do
  name = Faker::Name.name
  categorys.each { |category| category.products.create!(name: name, 
                                                        description: "jang nara",
                                                        image: "logo.jpg",
                                                        number_of_order: 100,
                                                        quantity: 10,
                                                        price: 100) }
end 

10.times do |n|
  name  = Faker::Name.name
  User.create!(name: "Nara - #{n}",
               email: "leductienttkt-#{n}@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               is_admin: false,
               address: "Quang Tri",
               phone: "01688576549") 
end

users = User.all

orderers = users[2..9]

10.times do |n|
  orderers.each do |orderer|
    orderer.orders.create!(receiver_name: orderer.name,
                 receiver_address: orderer.address,
                 receiver_phone: orderer.phone
                )
   end
end

orders = Order.all

5.times do |n|
  orders.each do |order|
    order.order_items.create!(quantity: 3,
                   product_id: 3
                   order_price: 90
                   )
  end
end



users = User.all

viewers = users[2..9]

10.times do |n|
  viewers.each do |viewer|
    viewer.recently_vieweds.create!(
      product_id: 10+n
                )
   end
end
