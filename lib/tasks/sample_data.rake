namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    ## create users

    8.times do |n|
      name  = Faker::Name.name
      email = "tester-#{n+1}@163.org"
      password = "111111"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    ## create products

    Product.create!(
      prod_name: "Pen",
      prod_price: 1,
      prod_amount: 1000,
      prod_desc: "Pen",
      prod_img: "pen-1.jpg")

    Product.create!(
      prod_name: "Notebook",
      prod_price: 2.05,
      prod_amount: 1000,
      prod_desc: "Notebook",
      prod_img: "notebook.jpg")

    Product.create!(
      prod_name: "Pencil",
      prod_price: 0.5,
      prod_amount: 1500,
      prod_desc: "Pencil",
      prod_img: "pencil.jpg")

    Product.create!(
      prod_name: "Ruler",
      prod_price: 1.2,
      prod_amount: 50,
      prod_desc: "Ruler",
      prod_img: "ruler.jpg")

    Product.create!(
      prod_name: "Clip x 10",
      prod_price: 0.2,
      prod_amount: 50,
      prod_desc: "Clips x 10",
      prod_img: "clip.jpg")

    Product.create!(
      prod_name: "Phone",
      prod_price: 10,
      prod_amount: 0,
      prod_desc: "Phone",
      prod_img: "phone.jpg")

    Product.create!(
      prod_name: "Rubber",
      prod_price: 0.1,
      prod_amount: 50,
      prod_desc: "Rubber",
      prod_img: "rubber.jpg")

    Product.create!(
      prod_name: "Pen Box",
      prod_price: 3,
      prod_amount: 50,
      prod_desc: "Pen Box",
      prod_img: "penbox.jpg")

    Product.create!(
      prod_name: "Knife",
      prod_price: 1.6,
      prod_amount: 50,
      prod_desc: "Knife",
      prod_img: "knife.jpg")

    Product.create!(
      prod_name: "Binding Machine",
      prod_price: 4,
      prod_amount: 50,
      prod_desc: "Binding Machine",
      prod_img: "bindingmachine.jpg")

    Product.create!(
      prod_name: "Color Pencil",
      prod_price: 0.6,
      prod_amount: 500,
      prod_desc: "Color Pencil",
      prod_img: "colorpencils.jpg")

    Product.create!(
      prod_name: "Cup",
      prod_price: 1.63,
      prod_amount: 500,
      prod_desc: "Cup",
      prod_img: "cup.jpg")

    Product.create!(
      prod_name: "Pen",
      prod_price: 4.3,
      prod_amount: 100,
      prod_desc: "Black pen",
      prod_img: "pen-2.jpg")

    Product.create!(
      prod_name: "Pen Case",
      prod_price: 3,
      prod_amount: 100,
      prod_desc: "Pen case",
      prod_img: "pencase.jpg")

    ### discount

    Discount.create!(
      product_id: 1,
      prod_qty: 2,
      discount: 0.9
    )

    Discount.create!(
      product_id: 1,
      prod_qty: 10,
      discount: 0.8
    )

    Discount.create!(
      product_id: 2,
      prod_qty: 10,
      discount: 0.7
    )

    Discount.create!(
      product_id: 3,
      prod_qty: 100,
      discount: 0.9
    )

    # freebies

    Freebie.create!(
      product_id: 1,
      prod_qty: 5,
      freebie_id: 1,
      freebie_qty: 1
    )

    Freebie.create!(
      product_id: 1,
      prod_qty: 10,
      freebie_id: 2,
      freebie_qty: 1
    )

    Freebie.create!(
      product_id: 3,
      prod_qty: 50,
      freebie_id: 7,
      freebie_qty: 1
    )
    
    Freebie.create!(
      product_id: 5,
      prod_qty: 10,
      freebie_id: 1,
      freebie_qty: 2
    )

    ### create carts

    20.times do |n|
    Cart.create!(
      user_id: n/5+1,
      product_id: n%5+1,
      amount: 5
    )
    end



  end
end
