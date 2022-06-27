FactoryBot.define do
  factory :transaction do
    order_id      { Faker::Internet.uuid }
    order_date    { Faker::Date.between(from: '2014-01-01', to: '2017-12-31') }
    ship_date     { Faker::Date.between(from: '2014-01-01', to: '2017-12-31') }
    customer_id   { Faker::Internet.uuid }
    state         { Faker::Address.state }
    region        { ["North", "West", "East", "South"].sample }
    product_id    { Faker::Internet.uuid }
    sales         { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    quantity      { Faker::Number.within(range: 1..50) }
  end
end