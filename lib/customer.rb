class Customer
  attr_accessor :name, :phone, :types_preference, :breed_preference
  attr_reader :id

  def initialize(attributes)
    @name = attributes[:name]
    @phone = attributes[:phone]
    @types_preference = attributes[:types_preference]
    @breed_preference = attributes[:breed_preference]
    @id = attributes[:id]
    @animals = []
  end

  def save
    result = DB.exec("INSERT INTO customers
     (name,phone,types_preference,breed_preference) VALUES
      ('#{@name}',#{@phone.to_i},'#{@types_preference}','#{@breed_preference}')
       RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_customer)
    self.name == another_customer.name
  end

  def add_animal(id)
    Animals.push(id)
  end

  def self.find(id)
    Customer.all.each do |customer|
      binding.pry
      if customer.id.to_i == id
        return customer
      end
    end
  end

  def self.all
    returned_customers = DB.exec("SELECT * FROM customers;")
    customers = []
    returned_customers.each do |customer|
      name = customer["name"]
      phone = customer["phone"]
      types_preference = customer["types_preference"]
      breed_preference = customer["breed_preference"]
      id = customer["id"]
      customers << Customer.new({name: name, phone: phone, types_preference: types_preference, breed_preference: breed_preference, id: id})
    end
    customers
  end
end
