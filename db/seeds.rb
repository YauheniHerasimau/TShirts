User.create(
  email: 'milko.gera@gmail.com',
  password: '14886663',
  password_confirmation: '14886663',
  admin: true,
  name: 'Admin'
)

User.create(
  email: 'example1@user.com',
  password: '123456',
  password_confirmation: '123456',
  admin: false,
  name: 'User'
)

User.create(
  email: 'example2@user.com',
  password: '123456',
  password_confirmation: '123456',
  admin: false,
  name: 'User2'
)

User.create(
  email: 'example3@user.com',
  password: '123456',
  password_confirmation: '123456',
  admin: false,
  name: 'User3'
)

categories = [
  { name: 'Casual', description: 'Everyday comfortable t-shirts' },
  { name: 'Sports', description: 'Athletic performance t-shirts' },
  { name: 'Graphic', description: 'T-shirts with printed designs' },
  { name: 'Premium', description: 'High-quality luxury t-shirts' }
]

categories.each do |category_attrs|
  Category.find_or_create_by!(name: category_attrs[:name]) do |category|
    category.description = category_attrs[:description]
  end
end

TShirt.create(
        name: "T-Shirt 1", 
        description: "This is the first T-Shirt", 
        size: "M", 
        price: 19.99,
        category: Category.find_by(name: 'Casual'),
        image_url: 'nigger.jpg',
        color: 'Black'
    )

TShirt.create(
        name: "T-Shirt 2", 
        description: "This is the second T-Shirt", 
        size: "L", 
        price: 24.99,
        category: Category.find_by(name: 'Sports'),
        image_url: 'ts2.jpg',
        color: 'Red'
    )

TShirt.create(
        name: "T-Shirt 3", 
        description: "This is the third T-Shirt", 
        size: "XL", 
        price: 29.99,
        category: Category.find_by(name: 'Graphic'),
        image_url: 'ts3.jpg',
        color: 'Blue'
    )

TShirt.create(
        name: "T-Shirt 4", 
        description: "This is the fourth T-Shirt", 
        size: "S", 
        price: 14.99,
        category: Category.find_by(name: 'Premium'),
        image_url: 'ts4.jpg',
        color: 'Yellow'
    )

TShirt.create(
        name: "T-Shirt 5", 
        description: "This is the fifth T-Shirt", 
        size: "S", 
        price: 14.99,
        category: Category.find_by(name: 'Premium'),
        image_url: 'ts5.jpg',
        color: 'Blue'
    )

TShirt.create(
        name: "T-Shirt 6", 
        description: "This is the sixth T-Shirt", 
        size: "S", 
        price: 14.99,
        category: Category.find_by(name: 'Premium'),
        image_url: 'ts6.jpg',
        color: 'Green'
    )
