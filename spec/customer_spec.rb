require 'rspec'
require 'customer'

DB = PG.connect({:dbname => 'animal_shelter_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM customers *;")
  end
end

describe Customer do
  describe(".all") do
    it("is empty at first") do
      RSpec.configure do |config|
        config.after(:each) do
          DB.exec("DELETE FROM customers *;")
        end
      end
      expect(Customer.all).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a customer to the array of saved customer ") do
      test_customer = Customer.new({:name => "Francis", :list_id => 1})
      test_customer.save
      expect(Customer.all).to(eq([test_customer]))
    end
  end

  describe("#name") do
    it("lets you read the name out") do
      test_customer = Customer.new({:name => "Francis", :list_id => 1})
      expect(test_customer.name).to(eq("Francis"))
    end
  end

  describe("#==") do
    it("is the same customer if it has the same name and list ID") do
      customer1 = Customer.new({:name => "Francis", :list_id => 1})
      customer2 = Customer.new({:name => "Francis", :list_id => 1})
      expect(customer1).to(eq(customer2))
    end
  end
end
