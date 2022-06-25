require "csv"

puts "Destroying existing transactions..."

Transaction.destroy_all

puts "Creating transactions..."

CSV.foreach("db/dataset.csv", headers: :first_row) do |row|
  transaction = Transaction.create!(
    order_id: row['Order ID'],
    order_date: row['Order Date'],
    customer_id: row['Customer ID'],
    state: row['State'],
    region: row['Region'],
    product_id: row['Product ID'],
    sales: row['Sales'],
    quantity: row['Quantity']
  )

  puts "Created transaction with ID #{transaction.id}"
end

puts "Transactions created: #{Transaction.count}"