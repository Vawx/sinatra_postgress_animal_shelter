class Customer
  attr_accessor :name, :phone, :types_preference, :breed_preference
  attr_reader :id

  def initialize(attributes)
    @name = attributes[:name]
    @phone = attributes[:phone]
    @types_preference = attributes[:types_preference]
    @breed_preference = attributes[:breed_preference]
  end

  def save
    result = DB.exec("INSERT INTO customers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_customer)
    self.name == another_customer.name
  end

  def self.all
    returned_customers = DB.exec("SELECT * FROM customers;")
    customers = []
    returned_customers.each do |customer|
      name = customer["name"]
      phone = customer["phone"]
      types_preference = customer["types_preference"]
      breed_preference = customer["breed_preference"]
      customers << Animal.new({name: name, phone: phone, types_preference: types_preference, breed_preference: breed_preference})
    end
    customers
  end
end
