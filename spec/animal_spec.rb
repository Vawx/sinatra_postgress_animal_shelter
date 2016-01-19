require 'rspec'
require 'animal'
require 'pg'

DB = PG.connect({:dbname => 'animal_shelter_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM animals *;")
  end
end

describe Animal do
  describe '.all' do
    it 'starts off with no animals' do
      expect(Animal.all).to(eq([]))
    end
  end

  describe '#name' do
    it 'tells you its name' do
      test_animal = Animal.new({name: "spot", id: nil})
      expect(test_animal.name).to(eq("spot"))
    end
  end

  describe '#id' do
    it 'sets its ID when you save it' do
      animal = Animal.new({name: "spot", id: nil})
      animal.save
      expect(animal.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe '#save' do
    it 'lets you save animals to the database' do
      animal = Animal.new({name: "spot", id: nil})
      animal.save
      expect(Animal.all).to(eq([animal]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      animal1 = Animal.new({:name => "Spot", :id => nil})
      animal2 = Animal.new({:name => "Spot", :id => nil})
      expect(animal1).to(eq(animal2))
    end
  end
end
