require_relative 'data/car_inventory'

def display_car_options
  puts "Please select a car make and model from the following options:"
  CAR_INVENTORY.each do |car, attributes|
    puts "- #{car}: #{attributes[:color]} #{attributes[:year]} - $#{attributes[:price]} - Available Qty: #{attributes[:available_qty]}"
  end
end

def select_car
  loop do
    display_car_options
    puts "Enter the car make and model you would like to select:"
    car_selection = gets.chomp.to_sym
    if CAR_INVENTORY.has_key?(car_selection)
      return car_selection
    else
      puts "Invalid car make and model. Please try again."
    end
  end
end

def get_customer_information
  puts "Please enter your full name:"
  full_name = gets.chomp
  puts "Please enter your mobile number:"
  mobile_number = gets.chomp
  puts "Please enter your delivery address:"
  delivery_address = gets.chomp
  return { full_name: full_name, mobile_number: mobile_number, delivery_address: delivery_address }
end

def save_car_selection(car_selection, customer_information)
  CAR_INVENTORY[car_selection][:available_qty] -= 1
  puts "Thank you for selecting #{car_selection}. Your order has been saved."
  puts "Customer Information:"
  puts "- Full Name: #{customer_information[:full_name]}"
  puts "- Mobile Number: #{customer_information[:mobile_number]}"
  puts "- Delivery Address: #{customer_information[:delivery_address]}"
  puts "Estimated Delivery Date: #{Time.now + (60*60*24*7)}"
end

def run_car_inventory_application
  loop do
    car_selection = select_car
    customer_information = get_customer_information
    save_car_selection(car_selection, customer_information)
    puts "Would you like to select another car? (y/n)"
    response = gets.chomp.downcase
    break if response == "n"
  end
  puts "Thank you for using the Car Inventory Application."
end

run_car_inventory_application