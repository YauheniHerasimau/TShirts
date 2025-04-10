User.create(
  email: 'milko.gera@gmail.com',
  password: '14886663',
  password_confirmation: '14886663',
  admin: true,
  name: 'Admin'
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
        image_url: 'images/nigger.jpg'
    )

TShirt.create(
        name: "T-Shirt 2", 
        description: "This is the second T-Shirt", 
        size: "L", 
        price: 24.99,
        category: Category.find_by(name: 'Sports')
    )

TShirt.create(
        name: "T-Shirt 3", 
        description: "This is the third T-Shirt", 
        size: "XL", 
        price: 29.99,
        category: Category.find_by(name: 'Graphic')
    )
