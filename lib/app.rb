require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

puts
puts Time.now.strftime("%m/%d/%Y %H:%M:%S %p")

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "
puts

brands = []

products_hash["items"].each do |item|
  total_sales = item["purchases"].map { |purchase| purchase["price"] }.reduce(:+)
  average_cost = total_sales / item["purchases"].count
  total_purchases = item["purchases"].count
  puts "- #{item["title"]} "
  puts "\tretail price - $#{item["full-price"].to_f}"
  puts "\tpurchases  - #{total_purchases}"
  puts "\ttotal sales - $#{total_sales}"
  puts "\taverage cost - $#{average_cost}"
  puts "\taverage discount - $#{(item["full-price"].to_f - average_cost)}\n\n"
  brands.push(item["brand"]) unless brands.include?(item["brand"])
end

# For each product in the data set:
# Print the name of the toy
# Print the retail price of the toy
# Calculate and print the total number of purchases
# Calculate and print the total amount of sales
# Calculate and print the average price the toy sold for
# Calculate and print the average discount (% or $) based off the average sales price


puts " _                         _     "
puts "| |                       | |    "
puts "| |__  _ __ __ _ _ __   __| |___ "
puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
puts "| |_) | | | (_| | | | | (_| \\__ \\"
puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
puts

# For each brand in the data set:
# Print the name of the brand
# Count and print the number of the brand's toys we stock
# Calculate and print the average price of the brand's toys
# Calculate and print the total revenue of all the brand's toy sales combined

brands.each do |brand|
  products = products_hash["items"].select { |item| item["brand"] == brand }

  stock = 0.0
  total_price = 0.0
  sales = 0.0

  products.each do |product|
    stock = stock + product["stock"]
    sales = sales + product["purchases"].length
    product["purchases"].each do |ind|
      total_price = total_price + ind["price"].to_f
    end
  end

  puts "Brand - #{brand}"
# should probably reword from "toys we stock" to "toys in stock" for the instructions above, can see why that's confusing to a lot of students
  puts "\ttotal products in stock - #{stock}"
  puts "\taverage price - $#{sprintf "%.2f", total_price / sales}"
  puts "\ttotal in sales - $#{sprintf "%.2f", total_price}\n\n"
#might be a better way to do decimals, but round wouldn't return two decimals if there's a 0 at first decimal
end
