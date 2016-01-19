class Animal
  attr_accessor :name, :gender, :admittance_date, :type, :breed, :customer_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes[:name]
    @gender = attributes[:gender]
    @type = attributes[:type]
    @breed = attributes[:breed]
    @id = attributes[:id]
    @customer_id = -1
  end

  def save
    result = DB.exec("INSERT INTO animals (name, breed, gender, type) VALUES ('#{@name}','#{@breed}','#{@gender}','#{@type}') RETURNING id, admittance_date;")
    @id = result.first.fetch("id").to_i
    @admittance_date = result.first.fetch("admittance_date")
  end

  def add_customer(customer_id)
    result = DB.exec("UPDATE animals SET customer_id = #{customer_id}")
    @customer_id = customer_id
  end

  def self.find(id)
    Animal.all.each do |animal|
      if animal.id == id
        return animal
      end
    end
  end

  def ==(another_animal)
    self.name == another_animal.name
  end

  def self.all
    returned_animals = DB.exec("SELECT * FROM animals;")
    animals = []
    returned_animals.each do |animal|
      name = animal["name"]
      gender = animal["gender"]
      admittance_date = animal["admittance_date"]
      type = animal["type"]
      breed = animal["breed"]
      id = animal["id"].to_i
      animals.push(Animal.new({name: name, gender: gender, type: type, breed: breed, id: id}))
    end
    animals
  end
end
